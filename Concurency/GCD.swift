// GCD -> GRAND CENTRAL DISPACH // its theoritical name of the DispatchQueue implementation
// ✅ GCD/DispatchQueue (Apple's main wrapper)
// types -> concurrent DispatchQueue and Serial DispatchQueue

// Initialization
// swift// Main queue (serial)
DispatchQueue.main
// Global concurrent queues
DispatchQueue.global(qos: .userInitiated)
DispatchQueue.global(qos: .userInteractive)
DispatchQueue.global(qos: .default)
DispatchQueue.global(qos: .utility)
DispatchQueue.global(qos: .background)
// Custom queue
DispatchQueue(label: "com.example.myqueue")
DispatchQueue(label: "com.example.myqueue", qos: .userInitiated)
DispatchQueue(label: "com.example.myqueue", attributes: .concurrent)
DispatchQueue(label: "com.example.myqueue", target: DispatchQueue.global())



// Key Properties
// swift// Queue identification
queue.label: String                    // Queue identifier
queue.qos: DispatchQoS                // Quality of service
// Queue attributes
.concurrent                           // Creates concurrent queue
.initiallyInactive                    // Queue starts inactive

// Essential Methods
// Async Execution
// swift
queue.async {
    // Background work
}
queue.async(group: group) {
    // Work with dispatch group
}
queue.async(flags: .barrier) {
    // Barrier work (concurrent queues only)
}

// Sync Execution
// swift
queue.sync {
    // Synchronous work
}
queue.sync(flags: .barrier) {
    // Synchronous barrier work
}

// Delayed Execution
// swift
queue.asyncAfter(deadline: .now() + 2.0) {
    // Execute after delay
}

queue.asyncAfter(wallDeadline: .now() + 2.0) {
    // Execute after wall clock delay
}


// Important Methods
// Queue Management
// swift
queue.activate()                      // Activate initially inactive queue
queue.suspend()                       // Suspend queue execution
queue.resume()                        // Resume suspended queue
queue.setTarget(queue: targetQueue)   // Set target queue

// Synchronization
// swift
queue.sync(execute: workItem)         // Execute work item synchronously
queue.async(execute: workItem)        // Execute work item asynchronously

// Context Checking
// swift
dispatchPrecondition(condition: .onQueue(queue))        // Debug assertion
dispatchPrecondition(condition: .notOnQueue(queue))     // Debug assertion


// Quality of Service Levels
// swift
.userInteractive      // UI updates, immediate
.userInitiated       // User-initiated, high priority
.default            // Default priority
.utility            // Long-running, low priority
.background         // Background tasks
.unspecified        // No QoS specified


// Common Usage Patterns
// swift// Background work, then UI update
DispatchQueue.global().async {
    // Heavy computation
    let result = processData()
    
    DispatchQueue.main.async {
        // Update UI
        self.updateUI(with: result)
    }
}

// Barrier pattern for concurrent queue
let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
concurrentQueue.async(flags: .barrier) {
    // Exclusive access
}
.barrier flag does not work on serial queues and has no effect on them. Already execute tasks one at a time in FIFO order



swift
DispatchQueue.main        // Serial
// This is the ONLY serial global queue
// Always serial, runs on main thread, for UI updates

Global Queues
DispatchQueue.global(qos: .userInteractive)  // Concurrent
DispatchQueue.global(qos: .userInitiated)    // Concurrent
DispatchQueue.global(qos: .default)          // Concurrent
DispatchQueue.global(qos: .utility)          // Concurrent
DispatchQueue.global(qos: .background)       // Concurrent
DispatchQueue.global(qos: .unspecified)      // Concurrent

Custom Queues
swiftDispatchQueue(label: "com.app.queue")                    // Serial
DispatchQueue(label: "com.app.queue", attributes: .concurrent)  // Concurrent

# Swift QoS (Quality of Service) Reference Table

| QoS Level | Priority | Duration | Thread Priority | Energy Impact | Use Cases | Examples |
|-----------|----------|----------|-----------------|---------------|-----------|-----------|
| **`.userInteractive`** | Highest | Instantaneous (0.0s) | Very High | High | UI updates, animations, user interface responsiveness | Button taps, scrolling, drawing, UI animations |
| **`.userInitiated`** | High | Few seconds or less | High | High | User-requested work they're waiting for | Loading documents, search results, user-triggered actions |
| **`.default`** | Normal | No specific expectation | Normal | Moderate | General work when no specific QoS needed | Data processing, networking, general tasks |
| **`.utility`** | Low | Seconds to minutes | Below Normal | Low | Long-running work that can be interrupted | Downloads, imports, maintenance, periodic sync |
| **`.background`** | Lowest | Minutes to hours | Very Low | Very Low | Work user isn't aware of | Backups, indexing, cleanup, analytics |
| **`.unspecified`** | System Decides | Undefined | System Determined | System Determined | Legacy support, let system decide | Compatibility, migration code |

## Code Examples

```swift
// UI Critical - Highest Priority
DispatchQueue.global(qos: .userInteractive).async {
    // Update UI elements, handle user interactions
}

// User Waiting - High Priority  
DispatchQueue.global(qos: .userInitiated).async {
    // Load file user just opened
}

// Normal Work - Default Priority
DispatchQueue.global(qos: .default).async {
    // Regular data processing
}

// Background Tasks - Low Priority
DispatchQueue.global(qos: .utility).async {
    // Download updates, sync data
}

// Maintenance - Lowest Priority
DispatchQueue.global(qos: .background).async {
    // Cleanup, backups, analytics
}

// System Decides - Unspecified
DispatchQueue.global(qos: .unspecified).async {
    // Legacy code, let system choose
}
```

## Key Guidelines

- **Higher QoS = More CPU/Memory/Energy consumption**
- **Lower QoS = Better battery life and system performance**
- **QoS can be promoted**: High-priority work can boost lower-priority work
- **Choose based on user expectations**: How quickly they expect results
- **Main queue always runs at userInteractive level**