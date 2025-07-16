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

