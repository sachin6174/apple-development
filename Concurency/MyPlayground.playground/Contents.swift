import Foundation

func blockingTask() {
    print("Start blocking task on thread: \(Thread.current)")
    Thread.sleep(forTimeInterval: 3) // Blocks the thread for 3 seconds
    print("End blocking task on thread: \(Thread.current)")
}

func nonBlockingTask() {
    print("Start non-blocking task on thread: \(Thread.current)")
    
    DispatchQueue.global().async {
        print("Doing work in background thread: \(Thread.current)")
        sleep(3) // Simulate long work
        print("Finished work in background thread")
    }
    
    print("End non-blocking task on thread: \(Thread.current)")
}

print("\n=== BLOCKING TASK ===")
blockingTask()

print("\n=== NON-BLOCKING TASK ===")
nonBlockingTask()

// Keep playground running to observe background thread
RunLoop.main.run(until: Date(timeIntervalSinceNow: 200))
