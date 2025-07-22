import UIKit

func downloadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        let image = UIImage(data: data)
        completion(image)
    }
    task.resume()
}

// Usage:
if let url = URL(string: "https://example.com/image.jpg") {
    downloadImage(with: url) { image in
        if let image = image {
            // Handle the downloaded image
        }
    }
}


func downloadImageWihCombine(with url: URL) -> AnyPublisher<UIImage?, Never> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .map { data, _ in
            return UIImage(data: data)
        }
        .replaceError(with: nil)
        .eraseToAnyPublisher()
}
// Usage:
if let url = URL(string: "https://example.com/image.jpg") {
    let cancellable = downloadImageWihCombine(with: url)
        .sink { image in
            if let image = image {
                // Handle the downloaded image
            }
        }
}


// async await
func downloadImage(with url: URL) async -> UIImage? {
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    } catch {
        return nil
    }
}
// Usage:

if let url = URL(string: "https://example.com/image.jpg") {
    Task {
        if let image = await downloadImage(with: url) {
            // Handle the downloaded image
        }
    }
}
