import Foundation

//synchronous version
func lineByLine() {
    sleep(5) // Mimics network call or task which takes time
    print("sachin after 5 sec of execution")
    
    sleep(10) // Additional 10 seconds delay
    print("kumar after 15 sec of execution")
    
    sleep(5) // Additional 5 seconds delay  
    print("end after 20 sec")
}
// lineByLine()// ran line by line



// async version
func lineByLineAsync() async {
    do {
        try await Task.sleep(nanoseconds: 5_000_000_000) // 5 seconds
        print("sachin after 5 sec of execution")
        
        try await Task.sleep(nanoseconds: 10_000_000_000) // 10 seconds
        print("kumar after 15 sec of execution")
        
        try await Task.sleep(nanoseconds: 5_000_000_000) // 5 seconds
        print("end after 20 sec")
    } catch {
        print("Sleep was interrupted: \(error)")
    }
}


// For async version:
Task {
    await lineByLineAsync()
}




// import Foundation

// 1. Using DispatchQueue.asyncAfter (GCD approach)
func lineByLineGCD() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        print("sachin after 5 sec of execution")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            print("kumar after 15 sec of execution")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                print("end after 20 sec")
            }
        }
    }
}

// 2. Using Timer (repeating approach)
func lineByLineTimer() {
    var step = 0
    var timer: Timer?
    
    timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
        step += 1
        switch step {
        case 1:
            print("sachin after 5 sec of execution")
        case 2:
            print("kumar after 15 sec of execution")
        case 3:
            print("end after 20 sec")
            timer?.invalidate()
        default:
            break
        }
    }
}

// 3. Using Combine framework (iOS 13+)
import Combine

func lineByLineCombine() {
    var cancellables = Set<AnyCancellable>()
    
    Timer.publish(every: 5, on: .main, in: .common)
        .autoconnect()
        .scan(0) { count, _ in count + 1 }
        .sink { step in
            switch step {
            case 1:
                print("sachin after 5 sec of execution")
            case 2:
                print("kumar after 15 sec of execution")
            case 3:
                print("end after 20 sec")
            default:
                break
            }
        }
        .store(in: &cancellables)
}

// 4. Using async/await with continuation
func lineByLineContinuation() {
    Task {
        await withDelay(5) {
            print("sachin after 5 sec of execution")
        }
        
        await withDelay(10) {
            print("kumar after 15 sec of execution")
        }
        
        await withDelay(5) {
            print("end after 20 sec")
        }
    }
}

func withDelay(_ seconds: Double, action: @escaping () -> Void) async {
    await withCheckedContinuation { continuation in
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            action()
            continuation.resume()
        }
    }
}

// 5. Using OperationQueue
func lineByLineOperationQueue() {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 1
    
    queue.addOperation {
        Thread.sleep(forTimeInterval: 5)
        OperationQueue.main.addOperation {
            print("sachin after 5 sec of execution")
        }
    }
    
    queue.addOperation {
        Thread.sleep(forTimeInterval: 10)
        OperationQueue.main.addOperation {
            print("kumar after 15 sec of execution")
        }
    }
    
    queue.addOperation {
        Thread.sleep(forTimeInterval: 5)
        OperationQueue.main.addOperation {
            print("end after 20 sec")
        }
    }
}

// 6. Using async sequence (iOS 15+)
func lineByLineAsyncSequence() {
    Task {
        let delays = [5, 10, 5]
        let messages = [
            "sachin after 5 sec of execution",
            "kumar after 15 sec of execution", 
            "end after 20 sec"
        ]
        
        for (index, delay) in delays.enumerated() {
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            print(messages[index])
        }
    }
}

// 7. Using closure-based approach with completion handlers
func lineByLineClosures() {
    executeWithDelay(5) {
        print("sachin after 5 sec of execution")
        
        executeWithDelay(10) {
            print("kumar after 15 sec of execution")
            
            executeWithDelay(5) {
                print("end after 20 sec")
            }
        }
    }
}

func executeWithDelay(_ seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

// 8. Using Thread.sleep on background queue
func lineByLineBackgroundThread() {
    DispatchQueue.global(qos: .background).async {
        Thread.sleep(forTimeInterval: 5)
        DispatchQueue.main.async {
            print("sachin after 5 sec of execution")
        }
        
        Thread.sleep(forTimeInterval: 10)
        DispatchQueue.main.async {
            print("kumar after 15 sec of execution")
        }
        
        Thread.sleep(forTimeInterval: 5)
        DispatchQueue.main.async {
            print("end after 20 sec")
        }
    }
}

// 9. Using usleep (microseconds) - C function
func lineByLineUsleep() {
    DispatchQueue.global().async {
        usleep(5_000_000) // 5 seconds in microseconds
        DispatchQueue.main.async {
            print("sachin after 5 sec of execution")
        }
        
        usleep(10_000_000) // 10 seconds in microseconds
        DispatchQueue.main.async {
            print("kumar after 15 sec of execution")
        }
        
        usleep(5_000_000) // 5 seconds in microseconds
        DispatchQueue.main.async {
            print("end after 20 sec")
        }
    }
}

// 10. Using CFRunLoopRunInMode (Core Foundation)
func lineByLineCoreFoundation() {
    DispatchQueue.global().async {
        CFRunLoopRunInMode(.defaultMode, 5.0, false)
        DispatchQueue.main.async {
            print("sachin after 5 sec of execution")
        }
        
        CFRunLoopRunInMode(.defaultMode, 10.0, false)
        DispatchQueue.main.async {
            print("kumar after 15 sec of execution")
        }
        
        CFRunLoopRunInMode(.defaultMode, 5.0, false)
        DispatchQueue.main.async {
            print("end after 20 sec")
        }
    }
}

// 11. Using DispatchSemaphore
func lineByLineSemaphore() {
    let semaphore = DispatchSemaphore(value: 0)
    
    DispatchQueue.global().async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("sachin after 5 sec of execution")
            semaphore.signal()
        }
        semaphore.wait()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            print("kumar after 15 sec of execution")
            semaphore.signal()
        }
        semaphore.wait()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("end after 20 sec")
            semaphore.signal()
        }
        semaphore.wait()
    }
}

// 12. Using async/await with AsyncSequence (custom)
func lineByLineCustomAsyncSequence() {
    Task {
        let delaySequence = DelaySequence(delays: [5, 10, 5])
        let messages = [
            "sachin after 5 sec of execution",
            "kumar after 15 sec of execution",
            "end after 20 sec"
        ]
        
        var index = 0
        for await _ in delaySequence {
            print(messages[index])
            index += 1
        }
    }
}

struct DelaySequence: AsyncSequence {
    typealias Element = Void
    let delays: [Double]
    
    func makeAsyncIterator() -> DelayIterator {
        DelayIterator(delays: delays)
    }
    
    struct DelayIterator: AsyncIteratorProtocol {
        let delays: [Double]
        var currentIndex = 0
        
        mutating func next() async throws -> Void? {
            guard currentIndex < delays.count else { return nil }
            
            let delay = delays[currentIndex]
            currentIndex += 1
            
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            return ()
        }
    }
}

// 13. Using Foundation's RunLoop
func lineByLineRunLoop() {
    DispatchQueue.global().async {
        RunLoop.current.run(until: Date().addingTimeInterval(5))
        DispatchQueue.main.async {
            print("sachin after 5 sec of execution")
        }
        
        RunLoop.current.run(until: Date().addingTimeInterval(10))
        DispatchQueue.main.async {
            print("kumar after 15 sec of execution")
        }
        
        RunLoop.current.run(until: Date().addingTimeInterval(5))
        DispatchQueue.main.async {
            print("end after 20 sec")
        }
    }
}

// 14. Using NSTimer (Objective-C style)
func lineByLineNSTimer() {
    var step = 0
    var timer: Timer?
    
    func scheduleNextStep() {
        step += 1
        let delay: TimeInterval
        
        switch step {
        case 1:
            delay = 5.0
        case 2:
            delay = 10.0
        case 3:
            delay = 5.0
        default:
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            switch step {
            case 1:
                print("sachin after 5 sec of execution")
            case 2:
                print("kumar after 15 sec of execution")
            case 3:
                print("end after 20 sec")
                return
            default:
                break
            }
            scheduleNextStep()
        }
    }
    
    scheduleNextStep()
}

// 15. Using DispatchWorkItem
func lineByLineDispatchWorkItem() {
    let workItem1 = DispatchWorkItem {
        print("sachin after 5 sec of execution")
    }
    
    let workItem2 = DispatchWorkItem {
        print("kumar after 15 sec of execution")
    }
    
    let workItem3 = DispatchWorkItem {
        print("end after 20 sec")
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem1)
    DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: workItem2)
    DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: workItem3)
}

// Usage examples:
// Synchronous (blocking):
// lineByLine()
// lineByLineBackgroundThread()
// lineByLineUsleep()
// lineByLineCoreFoundation()

// Asynchronous (non-blocking):
// lineByLineAsync()
// lineByLineGCD()
// lineByLineTimer()
// lineByLineCombine()
// lineByLineContinuation()
// lineByLineOperationQueue()
// lineByLineAsyncSequence()
// lineByLineClosures()
// lineByLineSemaphore()
// lineByLineCustomAsyncSequence()
// lineByLineRunLoop()
// lineByLineNSTimer()
// lineByLineDispatchWorkItem()


# Swift Functions: Blocking vs Non-blocking & Thread Analysis

## 🔴 BLOCKING Functions (Wait till execution completes)

| Function | Thread Behavior | UI Impact | Notes |
|----------|----------------|-----------|-------|
| `lineByLine()` | **Caller's thread** | ❌ Freezes UI if called on main | Uses `sleep()` - blocks completely |
| `lineByLineBackgroundThread()` | **Background thread** | ✅ No UI impact | Switches to background, then back to main for prints |
| `lineByLineUsleep()` | **Background thread** | ✅ No UI impact | Uses C function `usleep()` |
| `lineByLineCoreFoundation()` | **Background thread** | ✅ No UI impact | Uses Core Foundation RunLoop |
| `lineByLineRunLoop()` | **Background thread** | ✅ No UI impact | Uses Foundation RunLoop |
| `lineByLineSemaphore()` | **Background thread** | ✅ No UI impact | Uses semaphore to block and wait |
| `lineByLineOperationQueue()` | **Operation queue threads** | ✅ No UI impact | Each operation blocks its thread |

## 🟢 NON-BLOCKING Functions (Return immediately)

| Function | Thread Behavior | UI Impact | Notes |
|----------|----------------|-----------|-------|
| `lineByLineAsync()` | **Caller's thread** | ✅ No blocking | Uses `Task.sleep()` - yields control |
| `lineByLineGCD()` | **Main thread** | ✅ No blocking | Uses `DispatchQueue.main.asyncAfter` |
| `lineByLineTimer()` | **Main thread** | ✅ No blocking | Uses `Timer.scheduledTimer` |
| `lineByLineCombine()` | **Main thread** | ✅ No blocking | Uses Combine publishers |
| `lineByLineContinuation()` | **Main thread** | ✅ No blocking | Wraps async operations |
| `lineByLineAsyncSequence()` | **Caller's thread** | ✅ No blocking | Uses `Task.sleep()` in async context |
| `lineByLineClosures()` | **Main thread** | ✅ No blocking | Uses completion handlers |
| `lineByLineCustomAsyncSequence()` | **Caller's thread** | ✅ No blocking | Custom AsyncSequence with Task.sleep |
| `lineByLineNSTimer()` | **Main thread** | ✅ No blocking | Uses Timer with callbacks |
| `lineByLineDispatchWorkItem()` | **Main thread** | ✅ No blocking | Schedules work items |

## 📊 Detailed Thread Analysis

### **1. Functions that ALWAYS use Main Thread:**
```swift
lineByLineGCD()           // Forces main thread
lineByLineTimer()         // Main thread timer
lineByLineCombine()       // Main thread publisher
lineByLineContinuation()  // Main thread dispatch
lineByLineClosures()      // Main thread dispatch
lineByLineNSTimer()       // Main thread timer
lineByLineDispatchWorkItem() // Main thread dispatch
```

### **2. Functions that use Caller's Thread:**
```swift
lineByLine()              // Blocks caller's thread
lineByLineAsync()         // Yields on caller's thread
lineByLineAsyncSequence() // Yields on caller's thread
lineByLineCustomAsyncSequence() // Yields on caller's thread
```

### **3. Functions that create Background Threads:**
```swift
lineByLineBackgroundThread() // Creates background thread
lineByLineUsleep()           // Creates global queue thread
lineByLineCoreFoundation()   // Creates global queue thread
lineByLineRunLoop()          // Creates global queue thread
lineByLineSemaphore()        // Creates global queue thread
lineByLineOperationQueue()   // Creates operation queue threads
```

## 🎯 Practical Usage Examples

### **Safe for Main Thread (Non-blocking):**
```swift
// These are safe to call from main thread
DispatchQueue.main.async {
    lineByLineAsync()        // ✅ Safe
    lineByLineGCD()          // ✅ Safe
    lineByLineTimer()        // ✅ Safe
    lineByLineAsyncSequence() // ✅ Safe
}
```

### **Dangerous for Main Thread (Blocking):**
```swift
// These will freeze UI if called from main thread
DispatchQueue.main.async {
    lineByLine()             // ❌ Freezes UI for 20 seconds
    // Other blocking functions are safe as they switch to background
}
```

### **Background Thread Behavior:**
```swift
DispatchQueue.global().async {
    lineByLine()             // ✅ Blocks background thread (safe)
    lineByLineAsync()        // ✅ Yields on background thread (safe)
    lineByLineGCD()          // ⚠️ Still prints on main thread
}
```

## 🚀 Performance Characteristics

| Type | CPU Usage | Memory Usage | Responsiveness |
|------|-----------|--------------|----------------|
| **Blocking** | Low | Low | Poor (if on main thread) |
| **Non-blocking** | Slightly higher | Slightly higher | Excellent |

## 🎉 Recommendations

- **For UI Apps**: Use non-blocking functions (#2, #3, #15)
- **For Background Processing**: Use blocking functions (#8, #9, #10)
- **For Complex Workflows**: Use #7 (OperationQueue) or #12 (AsyncSequence)
- **For Simple Delays**: Use #3 (GCD) or #15 (DispatchWorkItem)



RunLoop.main.run(until: Date(timeIntervalSinceNow: 200))