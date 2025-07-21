// 1. Basic Function Declaration
func greet() {
    print("Hello!")
}
greet() // sample call for greet

// 2. Function with Parameters
func greetPerson(name: String) {
    print("Hello, \(name)!")
}
greetPerson(name: "Test Person") // sample call for greetPerson

// 3. Function with Return Value
func add(a: Int, b: Int) -> Int {
    return a + b
}
print("add:", add(a: 2, b: 3)) // sample call for add

// 4. Function with Multiple Return Values (Tuple)
func getMinMax(array: [Int]) -> (min: Int, max: Int)? {
    guard !array.isEmpty else { return nil }
    return (array.min()!, array.max()!)
}
if let result = getMinMax(array: [4, 2, 9, 1]) {
    print("Min:", result.min, "Max:", result.max)
}

// 5. Function with Default Parameter Values
func greetWithDefault(name: String = "Guest") {
    print("Hello, \(name)!")
}
greetWithDefault() // Uses default ("Guest")
greetWithDefault(name: "Alice") // sample call with parameter

// 6. Function with Variadic Parameters
func sum(_ numbers: Int...) -> Int {
    return numbers.reduce(0, +)
}
print("sum:", sum(1, 2, 3, 4, 5))

// 7. Function with inout Parameters
func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}
var x = 10
var y = 20
swapValues(&x, &y)
print("After swapValues: x = \(x), y = \(y)")

// 8. Function with External Parameter Names
func divide(numerator num: Int, by denom: Int) -> Double {
    return Double(num) / Double(denom)
}
print("divide:", divide(numerator: 10, by: 2))

// 9. Function with Omitted External Parameter Names
func multiply(_ a: Int, _ b: Int) -> Int {
    return a * b
}
print("multiply:", multiply(2, 3))

// 10. Function Types as Parameters
func performOperation(_ operation: (Int, Int) -> Int, on a: Int, and b: Int) -> Int {
    return operation(a, b)
}
print("performOperation:", performOperation({ $0 + $1 }, on: 3, and 4))

// using different argument label then parameter name 
func function3(first a: String, second b: Double){
    print("function2 got called and recieved a \(a) and b \(b)")
}
function3(first :"String", second: 3.1415926)

// 11. Function that Returns a Function
func makeIncrementer(incrementBy: Int) -> () -> Int {
    var total = 0
    return {
        total += incrementBy
        return total
    }
}
let incrementer = makeIncrementer(incrementBy: 2)
print("makeIncrementer first call:", incrementer())
print("makeIncrementer second call:", incrementer())

// 12. Generic Function
func swapAnyValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
var str1 = "Hello"
var str2 = "World"
swapAnyValues(&str1, &str2)
print("After swapAnyValues: \(str1), \(str2)")

// 13. Function with throws
enum MathError: Error {
    case divisionByZero
}

func divide(_ a: Int, by b: Int) throws -> Int {
    guard b != 0 else {
        throw MathError.divisionByZero
    }
    return a / b
}
do {
    let divResult = try divide(10, by: 2)
    print("divide throws result:", divResult)
} catch {
    print("Error in divide throws:", error)
}

// 14. Function with async/await
func fetchData() async throws -> String {
    // Simulating network call
    try await Task.sleep(nanoseconds: 1_000_000_000)
    return "Data"
}
Task {
    do {
        let data = try await fetchData()
        print("fetchData async result:", data)
    } catch {
        print("Error in fetchData:", error)
    }
}

// 15. Function with closure parameter
func performWithCompletion(work: () -> Void, completion: () -> Void) {
    work()
    completion()
}
performWithCompletion(
    work: { print("performWithCompletion: Working") },
    completion: { print("performWithCompletion: Done") }
)

// 16. Function with @escaping closure
func saveCompletion(completion: @escaping () -> Void) {
    DispatchQueue.main.async {
        completion()
    }
}
saveCompletion {
    print("saveCompletion: This will be executed asynchronously")
}

// Usage Examples:
func demonstrateUsage() {
    // Basic function call
    greet()

    // Function with parameter
    greetPerson(name: "John")

    // Function with return value
    let sum = add(a: 5, b: 3)

    // Tuple return
    if let result = getMinMax(array: [1, 2, 3, 4, 5]) {
        print("Min: \(result.min), Max: \(result.max)")
    }

    // Default parameter
    greetWithDefault()  // Uses "Guest"
    greetWithDefault(name: "Alice")

    // Variadic parameters
    let total = sum(1, 2, 3, 4, 5)

    // inout parameters
    var x = 10
    var y = 20
    swapValues(&x, &y)

    // External parameter names
    let result = divide(numerator: 10, by: 2)

    // Function type as parameter
    let addResult = performOperation(add, on: 5, and: 3)

    // Function returning function
    let incrementByTwo = makeIncrementer(incrementBy: 2)
    let first = incrementByTwo()  // 2
    let second = incrementByTwo()  // 4

    // Generic function
    var a = 10
    var b = 20
    swapAnyValues(&a, &b)

    // Error handling
    do {
        let result = try divide(10, by: 2)
        print(result)
    } catch {
        print("Error: \(error)")
    }

    // Async/await (must be called from async context)
    Task {
        do {
            let data = try await fetchData()
            print(data)
        } catch {
            print("Error: \(error)")
        }
    }

    // Closure usage
    performWithCompletion(
        work: { print("Working") },
        completion: { print("Done") }
    )
}


// Function Call Examples
func demonstrateAllFunctionCalls() {
    // 1. Basic Function Call
    greet()  // Output: Hello!

    // 2. Function with Parameters
    greetPerson(name: "John")  // Output: Hello, John!

    // 3. Function with Return Value
    let sum = add(a: 5, b: 3)
    print("Sum: \(sum)")  // Output: Sum: 8

    // 4. Function with Tuple Return
    let numbers = [1, 5, 3, 7, 2]
    if let result = getMinMax(array: numbers) {
        print("Min: \(result.min), Max: \(result.max)")  // Output: Min: 1, Max: 7
    }

    // 5. Function with Default Parameter
    greetWithDefault()  // Output: Hello, Guest!
    greetWithDefault(name: "Alice")  // Output: Hello, Alice!

    // 6. Variadic Function
    let total = sum(1, 2, 3, 4, 5)
    print("Total: \(total)")  // Output: Total: 15

    // 7. Function with inout Parameters
    var x = 10
    var y = 20
    print("Before swap: x = \(x), y = \(y)")
    swapValues(&x, &y)
    print("After swap: x = \(x), y = \(y)")

    // 8. Function with External Parameter Names
    let divisionResult = divide(numerator: 10, by: 2)
    print("Division: \(divisionResult)")  // Output: Division: 5.0

    // 9. Function with Omitted External Names
    let product = multiply(5, 4)
    print("Product: \(product)")  // Output: Product: 20

    // 10. Function Type as Parameter
    let operationResult = performOperation({ $0 * $1 }, on: 4, and: 5)
    print("Operation result: \(operationResult)")  // Output: Operation result: 20

    // 11. Function that Returns a Function
    let incrementer = makeIncrementer(incrementBy: 2)
    print(incrementer())  // Output: 2
    print(incrementer())  // Output: 4
    print(incrementer())  // Output: 6

    // 12. Generic Function
    var str1 = "Hello"
    var str2 = "World"
    print("Before swap: \(str1), \(str2)")
    swapAnyValues(&str1, &str2)
    print("After swap: \(str1), \(str2)")

    // 13. Function with Error Handling
    do {
        let result = try divide(10, by: 2)
        print("Safe division result: \(result)")
    } catch MathError.divisionByZero {
        print("Cannot divide by zero!")
    } catch {
        print("Unknown error: \(error)")
    }

    // 14. Async/Await Function
    Task {
        do {
            let data = try await fetchData()
            print("Fetched data: \(data)")
        } catch {
            print("Error fetching data: \(error)")
        }
    }

    // 15. Function with Closure Parameter
    performWithCompletion(
        work: {
            print("Doing some work...")
        },
        completion: {
            print("Work completed!")
        }
    )

    // 16. Function with Escaping Closure
    saveCompletion {
        print("This will be executed asynchronously")
    }

    // Additional Examples

    // Chaining Function Calls
    let result = add(a: multiply(2, 3), b: divide(numerator: 10, by: 2))
    print("Chained result: \(result)")

    // Using Function as Variable
    let mathFunc: (Int, Int) -> Int = add
    print("Math function result: \(mathFunc(5, 3))")

    // Array of Functions
    let operations: [(Int, Int) -> Int] = [
        add,
        multiply,
        { $0 - $1 },
    ]

    for operation in operations {
        print("Operation result: \(operation(10, 5))")
    }
}

// Optional: Run all examples
func runAllExamples() {
    print("Starting function call demonstrations...")
    demonstrateAllFunctionCalls()
    print("Finished function call demonstrations")
}

// Execute the examples
runAllExamples()


// return type function
func function5 (a: Int ,b: Int) -> Int{
    return a+b
}

// return without return keyword
func function6 (a: Int ,b: Int) -> Int{
   a+b // only application if there is only one statement
}


// function overloading
// function having same name with different number of paramaters // default parameter can beused to stop function overloading // removes duplicasy