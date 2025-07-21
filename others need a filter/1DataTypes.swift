//1. Basic Data Types
//Integers
//
//Int: A signed integer whose size is optimized for the current platform.
//Fixed-Width Integers: Such as Int8, Int16, Int32, and Int64 (and their unsigned counterparts: UInt, UInt8, UInt16, UInt32, UInt64).
//Floating‑Point Numbers
//
//Float: A 32‑bit floating‑point number.
//Double: A 64‑bit floating‑point number.
//Booleans
//
//Bool: Represents a Boolean value (true or false).
//Characters and Strings
//
//Character: A single-character string.
//String: A collection of characters.
//2. Collection Types
//Arrays
//
//Ordered collections of values, written as [Type].
//Dictionaries
//
//Collections of key‑value pairs, written as [KeyType: ValueType].
//Sets
//
//Unordered collections of unique values, using Set<Type>.
//3. Compound and Special Types
//Tuples
//
//Group multiple values into a single compound value. For example, (Int, String).
//Optionals
//
//A way to represent a value that may be absent. Declared with a ? (e.g., Int?).
//4. Custom Types
//Structures (struct)
//
//Value types that can encapsulate related properties and methods.
//Classes (class)
//
//Reference types that support inheritance and reference semantics.
//Enumerations (enum)
//
//Define a common type for a group of related values and can include associated values and methods.
//Protocols
//
//Define a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
//5. Function Types and Closures
//Function Types
//
//Functions in Swift are first‑class citizens. They can be assigned to variables or constants, passed as parameters, and returned from other functions. For example, a function that takes two Int values and returns an Int is written as (Int, Int) -> Int.
//Closures
//
//Self‑contained blocks of functionality that can capture and store references to variables and constants from the context in which they’re defined.
//6. Other Special Types
//Any
//
//Represents an instance of any type at all, including function types.
//AnyObject
//
//Represents an instance of any class type.
//Never
//
//Indicates that a function or method will never return normally (for example, functions that always throw an error or terminate the program).
//Self
//
//A special type that refers to the type in the context of its own definition.
//7. Pointer Types (for Interoperability)
//Unsafe Pointers
//Swift provides types like UnsafePointer, UnsafeMutablePointer, UnsafeRawPointer, and UnsafeMutableRawPointer for low‑level memory access (commonly used when interfacing with C APIs).
//Summary
//Swift’s rich type system provides everything from primitive types like Int, Double, and Bool, to powerful constructs such as arrays, dictionaries, optionals, tuples, and custom types (structs, classes, enums). In addition, special types like Any, AnyObject, and Never offer flexibility when you need to work with heterogeneous data or indicate unreturning functions. This diversity of types helps ensure that your code is both expressive and type‑safe.





// 1. Basic Data Types
// Integer Types
let integerNumber: Int = 42
let uint8Number: UInt8 = 255
let int16Number: Int16 = -32768
let uint32Number: UInt32 = 4294967295
let int64Number: Int64 = 9223372036854775807

// Floating-Point Types
let floatNumber: Float = 3.14159
let doubleNumber: Double = 3.14159265359

// Boolean Type
let isTrue: Bool = true
let isFalse: Bool = false

// Character and String Types
let singleCharacter: Character = "A"
let string: String = "Hello, Swift!"

// 2. Collection Types
// Array
let numbers: [Int] = [1, 2, 3, 4, 5]
let strings: Array<String> = ["Apple", "Banana", "Orange"]

// Dictionary
let scores: [String: Int] = ["John": 85, "Alice": 92]
let countries: Dictionary<String, String> = ["US": "United States", "UK": "United Kingdom"]

// Set
let uniqueNumbers: Set<Int> = [1, 2, 3, 3, 4] // Duplicates are automatically removed

// 3. Tuple Types
let coordinates: (Int, Int) = (10, 20)
let person: (name: String, age: Int, height: Double) = ("John", 25, 175.5)

// 4. Optional Types
let optionalString: String? = nil
let forcedString: String! = "Force unwrapped string"

// 5. Custom Types
// Enum
enum Direction {
    case north, south, east, west
}
let direction: Direction = .north

// Struct
struct Point {
    var x: Int
    var y: Int
}
let point: Point = Point(x: 10, y: 20)

// Class
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
let person1: Person = Person(name: "John", age: 25)

// 6. Type Aliases
typealias AudioSample = UInt16
let maxAmplitude: AudioSample = 32767

// 7. Special Types
let anyValue: Any = "Can be any type"
let anyObject: AnyObject = Person(name: "John", age: 25)

// 8. Range Types
let closedRange: ClosedRange<Int> = 1...5
let halfOpenRange: Range<Int> = 1..<5
let oneWayRange: PartialRangeFrom<Int> = 5...

// 9. Function Type
let mathOperation: (Int, Int) -> Int = { $0 + $1 }

// 10. Protocol Type
protocol Drawable {
    func draw()
}
class Circle: Drawable {
    func draw() {
        print("Drawing circle")
    }
}
let shape: Drawable = Circle()

// 11. Type Conversion Examples
let integer = 42
let doubleFromInt = Double(integer)
let stringFromInt = String(integer)
let intFromString = Int("42") // Optional(42)

// 12. Type Checking
let value: Any = "Hello"
if value is String {
    print("Value is a string")
}

// 13. Optional Binding
if let unwrappedString = optionalString {
    print(unwrappedString)
}
