// 1. For-in loop with ranges
// Closed range
for i in 1...5 {
    print(i)  // prints 1, 2, 3, 4, 5
}

// Half-open range
for i in 0..<5 {
    print(i)  // prints 0, 1, 2, 3, 4
}

// 2. For-in loop with arrays
let fruits = ["apple", "banana", "orange"]
for fruit in fruits {
    print(fruit)
}

// With enumerated() to get index and value
for (index, fruit) in fruits.enumerated() {
    print("\(index): \(fruit)")
}

// 3. For-in loop with dictionaries
let scores = ["John": 85, "Alice": 92, "Bob": 78]
for (name, score) in scores {
    print("\(name) scored \(score)")
}

// 4. While loop
var counter = 0
while counter < 5 {
    print(counter)
    counter += 1
}

// 5. Repeat-while loop (do-while equivalent)
var number = 1
repeat {
    print(number)
    number += 1
} while number <= 3

// 6. Stride loops
// Counting up by 2
for i in stride(from: 0, to: 10, by: 2) {
    print(i)  // prints 0, 2, 4, 6, 8
}

// Counting down
for i in stride(from: 10, through: 0, by: -2) {
    print(i)  // prints 10, 8, 6, 4, 2, 0
}

// 7. For-in with Set
let numberSet: Set = [1, 2, 3, 4, 5]
for num in numberSet {
    print(num)
}

// 8. Breaking and continuing
for i in 1...10 {
    if i == 3 { continue }  // skip 3
    if i == 8 { break }  // stop at 8
    print(i)
}

// 9. For-in with where clause
for i in 1...10 where i % 2 == 0 {
    print(i)  // prints even numbers only
}

// 10. Using the forEach Method

let fruits = ["apple", "banana", "orange"]
fruits.forEach { fruit in
    print(fruit)
}

// 11. Pattern Matching in Loops

let optionalNumbers: [Int?] = [1, nil, 3, nil, 5]
for case let number? in optionalNumbers {
    print(number)  // prints 1, 3, 5
}


// 13. Using while let for Optional Binding
var optionalValue: Int? = 5
while let value = optionalValue, value > 0 {
    print(value)
    optionalValue = value - 1
}


// 14. Nested Loops

for i in 1...3 {
    for j in 1...3 {
        print("(\(i), \(j))")
    }
}



// 15. Iterating Over Custom Sequences

struct Countdown: Sequence {
    let start: Int
    func makeIterator() -> AnyIterator<Int> {
        var current = start
        return AnyIterator {
            if current <= 0 {
                return nil
            } else {
                defer { current -= 1 }
                return current
            }
        }
    }
}

for number in Countdown(start: 5) {
    print(number)  // prints 5, 4, 3, 2, 1
}
