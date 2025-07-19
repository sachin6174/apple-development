import Foundation
import PlaygroundSupport

// Enable asynchronous execution in playground
PlaygroundPage.current.needsIndefiniteExecution = true

class DownloadManager {
    
    enum DownloadMode {
        case concurrent
        case serial
    }
    
    enum DownloadError: Error {
        case invalidURL
        case downloadFailed(Error)
        case fileWriteFailed
    }
    
    static func downloadFiles(
        urls: [String],
        mode: DownloadMode,
        qos: DispatchQoS.QoSClass = .userInitiated,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        switch mode {
        case .concurrent:
            downloadConcurrently(urls: urls, qos: qos, completion: completion)
        case .serial:
            downloadSerially(urls: urls, qos: qos, completion: completion)
        }
    }
    
    // MARK: - Concurrent Download
    private static func downloadConcurrently(
        urls: [String],
        qos: DispatchQoS.QoSClass,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        let dispatchGroup = DispatchGroup()
        var downloadedPaths: [String] = Array(repeating: "", count: urls.count)
        let errorQueue = DispatchQueue(label: "error.queue") // Synchronize error access
        var hasError: Error?
        
        for (index, urlString) in urls.enumerated() {
            dispatchGroup.enter()
            
            DispatchQueue.global(qos: qos).async {
                downloadSingleFile(urlString: urlString, qos: qos) { result in
                    defer { dispatchGroup.leave() }
                    
                    switch result {
                    case .success(let path):
                        downloadedPaths[index] = path
                    case .failure(let error):
                        errorQueue.sync {
                            if hasError == nil { // Only set the first error
                                hasError = error
                            }
                        }
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global(qos: qos)) {
            DispatchQueue.main.async {
                if let error = hasError {
                    completion(.failure(error))
                } else {
                    completion(.success(downloadedPaths))
                }
            }
        }
    }
    
    // MARK: - Serial Download
    private static func downloadSerially(
        urls: [String],
        qos: DispatchQoS.QoSClass,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        var downloadedPaths: [String] = []
        
        func downloadNext(index: Int) {
            guard index < urls.count else {
                DispatchQueue.main.async {
                    completion(.success(downloadedPaths))
                }
                return
            }
            
            DispatchQueue.global(qos: qos).async {
                downloadSingleFile(urlString: urls[index], qos: qos) { result in
                    switch result {
                    case .success(let path):
                        downloadedPaths.append(path)
                        downloadNext(index: index + 1)
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
        
        downloadNext(index: 0)
    }
    
    // MARK: - Single File Download
    private static func downloadSingleFile(
        urlString: String,
        qos: DispatchQoS.QoSClass,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(DownloadError.invalidURL))
            return
        }
        
        // Create URLSession with specified QoS
        let config = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = QualityOfService(qos: qos)
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: operationQueue)
        
        let task = session.downloadTask(with: url) { tempURL, response, error in
            if let error = error {
                completion(.failure(DownloadError.downloadFailed(error)))
                return
            }
            
            guard let tempURL = tempURL else {
                completion(.failure(DownloadError.downloadFailed(NSError(domain: "DownloadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No temp URL"]))))
                return
            }
            
            // Create destination path
            let fileName = url.lastPathComponent.isEmpty ? "downloaded_file_\(UUID().uuidString)" : url.lastPathComponent
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsPath.appendingPathComponent(fileName)
            
            do {
                // Remove existing file if it exists
                if FileManager.default.fileExists(atPath: destinationURL.path) {
                    try FileManager.default.removeItem(at: destinationURL)
                }
                
                // Move downloaded file to documents directory
                try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                completion(.success(destinationURL.path))
                
            } catch {
                completion(.failure(DownloadError.fileWriteFailed))
            }
        }
        
        task.resume()
    }
}

// MARK: - QoS Extension
extension QualityOfService {
    init(qos: DispatchQoS.QoSClass) {
        switch qos {
        case .userInteractive:
            self = .userInteractive
        case .userInitiated:
            self = .userInitiated
        case .default:
            self = .default
        case .utility:
            self = .utility
        case .background:
            self = .background
        case .unspecified:
            self = .default
        @unknown default:
            self = .default
        }
    }
}

// MARK: - Usage Example
let urls = [
    "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
    "https://httpbin.org/image/jpeg",
    "https://sample-videos.com/zip/10/mp3/mp3-10s.zip"
]

print("🚀 Starting downloads...")

// Function to start serial download
func startSerialDownload() {
    print("⚡ Starting serial downloads...")
    DownloadManager.downloadFiles(urls: urls, mode: .serial, qos: .userInitiated) { result in
        switch result {
        case .success(let paths):
            print("✅ Serial - All files downloaded successfully!")
            print("📁 Serial Downloaded paths:")
            paths.enumerated().forEach { index, path in
                print("   \(index + 1). \(path)")
            }
            print("🎉 All downloads completed!")
            
            // Stop playground execution
            PlaygroundPage.current.finishExecution()
            
        case .failure(let error):
            print("❌ Serial Download failed: \(error)")
            PlaygroundPage.current.finishExecution()
        }
    }
}

// Start with concurrent downloads
print("⚡ Starting concurrent downloads...")
DownloadManager.downloadFiles(urls: urls, mode: .concurrent, qos: .userInitiated) { result in
    switch result {
    case .success(let paths):
        print("✅ Concurrent - All files downloaded successfully!")
        print("📁 Concurrent Downloaded paths:")
        paths.enumerated().forEach { index, path in
            print("   \(index + 1). \(path)")
        }
        print("")
        
        // After concurrent download completes, start serial download
        startSerialDownload()
        
    case .failure(let error):
        print("❌ Concurrent Download failed: \(error)")
        // Still try serial download even if concurrent fails
        startSerialDownload()
    }
}



// run in playground


// Keep playground running to observe background thread
RunLoop.main.run(until: Date(timeIntervalSinceNow: 200))