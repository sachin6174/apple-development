/ ❌ Thread-unsafe: Multiple threads competing for array mutation
var downloadedPaths: [String] = []
downloadedPaths.append(path) // Dangerous - race condition on array size/capacity

Fix 1: Actor for Thread-Safe State Management
swiftactor DownloadResults {
    private var paths: [String] = []
    
    func addPath(_ path: String) {
        paths.append(path)
    }
    
    func getAllPaths() -> [String] {
        return paths
    }
}

// Usage
let results = DownloadResults()
await withTaskGroup(of: Void.self) { group in
    for urlString in urls {
        group.addTask {
            let path = await downloadSingleFile(urlString: urlString, qos: qos)
            await results.addPath(path)
        }
    }
}
let downloadedPaths = await results.getAllPaths()
Fix 2: Serial Queue with DispatchQueue
swiftvar downloadedPaths: [String] = []
let serialQueue = DispatchQueue(label: "downloadResults")

// In your concurrent download completion handler:
downloadSingleFile(urlString: urlString, qos: qos) { path in
    serialQueue.async {
        downloadedPaths.append(path) // Now thread-safe
    }
}
Fix 3: NSLock for Synchronization
swiftvar downloadedPaths: [String] = []
let lock = NSLock()

downloadSingleFile(urlString: urlString, qos: qos) { path in
    lock.lock()
    downloadedPaths.append(path)
    lock.unlock()
}
Fix 4: Concurrent Queue with Barrier
swiftvar downloadedPaths: [String] = []
let concurrentQueue = DispatchQueue(label: "downloadResults", attributes: .concurrent)

downloadSingleFile(urlString: urlString, qos: qos) { path in
    concurrentQueue.async(flags: .barrier) {
        downloadedPaths.append(path) // Barrier ensures exclusive write access
    }
}
Fix 5: Modern Swift - TaskGroup with Collecting Results
swiftfunc downloadFilesConcurrently(urls: [String]) async -> [String] {
    await withTaskGroup(of: String.self) { group in
        // Add all download tasks
        for url in urls {
            group.addTask {
                return await downloadSingleFile(urlString: url, qos: .userInitiated)
            }
        }
        
        // Collect results safely
        var results: [String] = []
        for await path in group {
            results.append(path) // Safe because TaskGroup handles synchronization
        }
        return results
    }
}
Fix 6: Atomic Operations with OSAtomic (Advanced)
swiftimport os

var downloadedPaths: [String] = []
let lock = OSAllocatedUnfairLock()

downloadSingleFile(urlString: urlString, qos: qos) { path in
    lock.withLock {
        downloadedPaths.append(path)
    }
}
Why Your Original Solution is Still Best
Your pre-sized array approach (Array(repeating: "", count: urls.count)) is actually the most efficient because:

No synchronization overhead - each thread writes to its own index
No memory reallocation - array size is fixed from start
Predictable performance - O(1) writes vs potential O(n) for array growth
Maintains order - results appear in same order as input URLs