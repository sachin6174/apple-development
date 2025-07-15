/*
The Architecture:
Your Code
    ↓
DispatchQueue (GCD Layer)
    ↓
Thread Pool Management
    ↓
Actual Threads (Foundation/System)

GCD is Apple's sophisticated wrapper that makes thread management much easier, more efficient, and less error-prone than working with raw threads directly.


All direct and indirect threads:
✅ Thread (Raw threads)
✅ GCD/DispatchQueue (Apple's main wrapper)
✅ NSOperationQueue (Higher-level wrapper)
✅ Swift Concurrency (async/await, Actor)
✅ Reactive frameworks (RxSwift, Combine)
✅ Third-party libraries (PromiseKit, etc.)

For 99% of iOS/macOS development, you'll only use:
DispatchQueue (GCD) - Most common
async/await - Modern Swift
NSOperationQueue - When you need dependencies
Combine - For reactive programming

*/

// Direct threads

// 1. Block-based (no parameters)
import Foundation

func createThread() {
    let thread = Thread {
        // No parameters allowed here
        print("Thread started: \(Thread.current)")
        Thread.sleep(forTimeInterval: 2)
        print("Thread finished")
    }
    
    thread.start()
}

createThread()


/*
let demo = ThreadDemo()
demo.name = "sachin"
Summary of Thread Properties:
Configuration Properties:

name - Thread name (String?)
threadPriority - Priority 0.0-1.0 (Double)
qualityOfService - QoS level (QualityOfService)
stackSize - Stack size in bytes (Int)

State Properties (Read-only):

isExecuting - Currently running (Bool)
isFinished - Has completed (Bool)
isCancelled - Has been cancelled (Bool)
isMainThread - Is main thread (Bool)

Instance Methods:

start() - Start the thread
cancel() - Cancel the thread

Class Methods:

Thread.current - Get current thread
Thread.main - Get main thread
Thread.isMainThread - Check if on main thread
Thread.sleep(forTimeInterval:) - Sleep for duration
Thread.sleep(until:) - Sleep until date
Thread.exit() - Exit current thread
Thread.detachNewThreadSelector(...) - Create detached thread

Important Notes:

Configure properties before calling start()
Use isCancelled to check for cancellation in your work
Thread objects can only be started once
Always check Thread.current.isCancelled in long-running work

*/


// // 2. Target-action based
// let thread2 = Thread(target: self, selector: #selector(method), object: nil)

// // 3. Detached thread (class method)
// Thread.detachNewThreadSelector(#selector(method), toTarget: self, with: nil)


RunLoop.main.run(until: Date(timeIntervalSinceNow: 200))