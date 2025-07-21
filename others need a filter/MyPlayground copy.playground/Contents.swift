import Cocoa

var greeting = "Hello, playground"
print(1...5)
let a = (1...6)
print(type(of: 1.0...6.0))

print(String(describing: [3,7,8]))

// Define a custom stream that conforms to TextOutputStream
struct StringOutputStream: TextOutputStream {
    var output = ""
    
    mutating func write(_ string: String) {
        output += string
    }
}

// Use the custom stream with print
var myStream = StringOutputStream()
print("Hello", "Swift", to: &myStream)
print("Custom stream works!", to: &myStream)

// The content of the custom stream now holds all printed text.
print("Captured text:")
print(myStream.output)


var range = "My range: "
print(1...5, to: &range)
// range == "My range: 1...5\n"


let greeting2 = "Hello, Swift!"

// Using String(describing:) gives a simple, user-friendly description.
print(String(describing: greeting2))
// Output: Hello, Swift!

// Using String(reflecting:) gives a debug-oriented description.
print(String(reflecting: greeting2))
// Output: "Hello, Swift!"

debugPrint(1...5)
// Prints "ClosedRange(1...5)"


//// Define a sample struct with nested properties
//struct Person {
//    let name: String
//    let age: Int
//    let friends: [String]
//}
//
//let person = Person(name: "Alice", age: 30, friends: ["Bob", "Charlie", "Dave"])
//
//// Dump the person's details
//dump(person, name: "Person Details", indent: 0)
//print(type(of: dump(person, name: "Person Details", indent: 0)))






// Define a custom text output stream that appends output to a string.
struct StringOutputStream2: TextOutputStream {
    var output = ""
    mutating func write(_ string: String) {
        output += string
    }
}

var myStream2 = StringOutputStream2()

// Define a simple structure
struct Person {
    let name: String
    let age: Int
}

let person = Person(name: "Alice", age: 30)

// Dump the details of 'person' to the custom stream
dump(person, to: &myStream, name: "Person Details", indent: 2)

// Now, 'myStream.output' contains the detailed dump information.
print("Dump Output:")
print(myStream.output)
