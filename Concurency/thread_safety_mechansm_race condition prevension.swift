import Foundation
import os

// MARK: - 1. Bank Account Simulator (Race Condition & Locks)

class BankAccount {
    private var balance: Int
    init(balance: Int) { self.balance = balance }

    func deposit(amount: Int) {
        let newBalance = balance + amount
        print("Depositing \(amount), new balance: \(newBalance)")
        balance = newBalance
    }

    func withdraw(amount: Int) {
        guard balance >= amount else {
            print("Insufficient funds for withdrawal of \(amount). Current balance: \(balance)")
            return
        }
        let newBalance = balance - amount
        print("Withdrawing \(amount), new balance: \(newBalance)")
        balance = newBalance
    }

    func getBalance() -> Int { return balance }
}

// Without synchronization, this will cause race conditions
func raceConditionDemo() {
    let account = BankAccount(balance: 1000)
    let queue = DispatchQueue.global(qos: .userInitiated)
    for _ in 0..<100 {
        queue.async {
            account.withdraw(amount: 10)
        }
        queue.async {
            account.deposit(amount: 10)
        }
    }
    sleep(2)
    print("Final balance: \(account.getBalance())")
}

// Synchronizing with NSLock
def nsLockDemo() {
    let account = BankAccount(balance: 1000)
    let lock = NSLock()
    let queue = DispatchQueue.global()
    for _ in 0..<100 {
        queue.async {
            lock.lock()
            account.withdraw(amount: 10)
            lock.unlock()
        }
        queue.async {
            lock.lock()
            account.deposit(amount: 10)
            lock.unlock()
        }
    }
    sleep(2)
    print("Final balance with NSLock: \(account.getBalance())")
}

// Synchronizing with os_unfair_lock
def unfairLockDemo() {
    let account = BankAccount(balance: 1000)
    var unfairLock = os_unfair_lock()
    let queue = DispatchQueue.global()
    for _ in 0..<100 {
        queue.async {
            os_unfair_lock_lock(&unfairLock)
            account.withdraw(amount: 10)
            os_unfair_lock_unlock(&unfairLock)
        }
        queue.async {
            os_unfair_lock_lock(&unfairLock)
            account.deposit(amount: 10)
            os_unfair_lock_unlock(&unfairLock)
        }
    }
    sleep(2)
    print("Final balance with unfair lock: \(account.getBalance())")
}

// Equivalent to @synchronized
def synchronized(_ lock: AnyObject, closure: () -> Void) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

func synchronizedDemo() {
    let account = BankAccount(balance: 1000)
    let queue = DispatchQueue.global()
    for _ in 0..<100 {
        queue.async {
            synchronized(account) {
                account.withdraw(amount: 10)
            }
        }
        queue.async {
            synchronized(account) {
                account.deposit(amount: 10)
            }
        }
    }
    sleep(2)
    print("Final balance with @synchronized: \(account.getBalance())")
}

// MARK: - 2. DispatchSemaphore
def dispatchSemaphoreDemo() {
    let semaphore = DispatchSemaphore(value: 2) // allow up to 2 concurrent accesses
    let queue = DispatchQueue.global()
    for i in 1...5 {
        queue.async {
            semaphore.wait()
            print("Task \(i) started")
            sleep(1)
            print("Task \(i) ended")
            semaphore.signal()
        }
    }
    sleep(6)
}

// MARK: - 3. DispatchGroup
def dispatchGroupDemo() {
    let group = DispatchGroup()
    let queue = DispatchQueue.global()
    for i in 1...3 {
        group.enter()
        queue.async {
            print("Task \(i) in group started")
            sleep(UInt32(i))
            print("Task \(i) in group completed")
            group.leave()
        }
    }
    group.notify(queue: DispatchQueue.main) {
        print("All group tasks completed")
        CFRunLoopStop(CFRunLoopGetMain())
    }
    CFRunLoopRun()
}

// MARK: - 4. DispatchBarrier
def dispatchBarrierDemo() {
    let queue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
    for i in 1...3 {
        queue.async {
            print("Read \(i)")
            sleep(1)
        }
    }
    queue.async(flags: .barrier) {
        print("Barrier write")
        sleep(2)
    }
    for i in 4...6 {
        queue.async {
            print("Read \(i)")
            sleep(1)
        }
    }
    sleep(6)
}

// MARK: - Execute Demos
func runAllDemos() {
    print("\n--- Race Condition Demo ---")
    raceConditionDemo()
    print("\n--- NSLock Demo ---")
    nsLockDemo()
    print("\n--- Unfair Lock Demo ---")
    unfairLockDemo()
    print("\n--- @synchronized Demo ---")
    synchronizedDemo()
    print("\n--- DispatchSemaphore Demo ---")
    dispatchSemaphoreDemo()
    print("\n--- DispatchGroup Demo ---")
    dispatchGroupDemo()
    print("\n--- DispatchBarrier Demo ---")
    dispatchBarrierDemo()
}

runAllDemos()
