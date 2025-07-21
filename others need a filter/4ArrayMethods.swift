import Foundation

// 1. Creating Arrays
var array1: [Int] = [1, 2, 3, 4, 5]
var array2 = ["apple", "banana", "cherry"]

// 2. Count & isEmpty
print("array1:", array1)
print("Count:", array1.count)
print("Is Empty:", array1.isEmpty)

// 3. Appending Elements
array1.append(6)
print("After appending 6:", array1)

// 4. Inserting Elements
array1.insert(0, at: 0)
print("After inserting 0 at beginning:", array1)

// 5. Removing Elements by Index
let removedElement = array1.remove(at: 3)
print("Removed element at index 3 (value \(removedElement)):", array1)

// 6. Removing the Last Element
let removedLast = array2.removeLast()
print("Removed last element of array2 (\(removedLast)):", array2)

// 7. Removing All Elements
var array3 = [10, 20, 30]
array3.removeAll()
print("array3 after removeAll:", array3)

// 8. Accessing Elements via Subscript
print("First element of array1:", array1[0])

// 9. Iterating Over Elements Using for-loop
print("Iterating over array1 with a for-loop:")
for element in array1 {
    print(element, terminator: " ")
}
print()

// 10. Iterating Over Elements Using forEach
print("Iterating over array1 with forEach:")
array1.forEach { print($0, terminator: " ") }
print()

// 11. Transforming an Array Using map
let squareArray = array1.map { $0 * $0 }
print("Squares of array1:", squareArray)

// 12. Filtering Elements Using filter
let evenNumbers = array1.filter { $0 % 2 == 0 }
print("Even numbers in array1:", evenNumbers)

// 13. Reducing Elements Using reduce
let sum = array1.reduce(0, +)
print("Sum of elements in array1 using reduce:", sum)

// 14. Sorting Arrays
let unsortedArray = [3, 1, 4, 5, 2]
let sortedArray = unsortedArray.sorted()
print("Sorted array (non-mutating):", sortedArray)

var mutableArray = unsortedArray
mutableArray.sort()
print("mutableArray after sort() (in-place):", mutableArray)

// 15. Checking if an Array Contains an Element
print("array1 contains 4:", array1.contains(4))
print("array1 contains 100:", array1.contains(100))

// 16. Accessing First and Last Elements
print("First element of array1:", array1.first ?? "None")
print("Last element of array1:", array1.last ?? "None")

// 17. Finding Index of an Element
if let index = array1.firstIndex(of: 4) {
    print("Index of element 4 in array1:", index)
}
if let indexEven = array1.firstIndex(where: { $0 % 2 == 0 }) {
    print("First even element is at index:", indexEven)
}

// 18. Reversing an Array
let reversedArray = array1.reversed()
print("Reversed array1:", Array(reversedArray))  // reversed() returns a ReversedCollection

// 19. Joining Array Elements into a String (for arrays of strings)
let fruits = ["Apple", "Banana", "Cherry"]
let joinedFruits = fruits.joined(separator: ", ")
print("Joined fruits:", joinedFruits)

// 20. Chunking an Array (Custom Method)
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var result = [[Element]]()
        for i in stride(from: 0, to: self.count, by: size) {
            let chunk = Array(self[i ..< Swift.min(i + size, self.count)])
            result.append(chunk)
        }
        return result
    }
}
let chunkedArray = unsortedArray.chunked(into: 2)
print("Chunked unsortedArray into chunks of size 2:", chunkedArray)

// 21. Converting and Filtering with compactMap
let stringNumbers = ["1", "2", "three", "4"]
let convertedNumbers = stringNumbers.compactMap { Int($0) }
print("Converted valid strings to numbers using compactMap:", convertedNumbers)

// 22. Flattening Nested Arrays with flatMap
let nestedArray = [[1, 2], [3, 4], [5]]
let flattenedArray = nestedArray.flatMap { $0 }
print("Flattened nestedArray using flatMap:", flattenedArray)

// 23. Enumerating Array Elements
print("Enumerating elements in array1:")
for (index, value) in array1.enumerated() {
    print("Index \(index): Value \(value)")
}

// 24. Custom Sorting Using a Comparator
let customSorted = unsortedArray.sorted { $0 > $1 }
print("Custom sorted (descending) unsortedArray:", customSorted)

// 25. Reserving Capacity
var largeArray: [Int] = []
largeArray.reserveCapacity(100)
print("Reserved capacity for largeArray:", largeArray.capacity)

// 26. Slicing Arrays (prefix and suffix)
let firstThree = array1.prefix(3)
let lastThree = array1.suffix(3)
print("First three elements of array1:", firstThree)
print("Last three elements of array1:", lastThree)

// 27. Appending Contents of Another Array
let moreNumbers = [7, 8, 9]
array1.append(contentsOf: moreNumbers)
print("After appending contentsOf moreNumbers:", array1)

// 28. Replacing a Subrange
if array1.count > 5 {
    array1.replaceSubrange(2...4, with: [100, 200])
    print("After replacing subrange (2...4), array1:", array1)
}

// 29. Removing a Subrange
if array1.count > 4 {
    array1.removeSubrange(0..<2)
    print("After removing subrange (0..<2), array1:", array1)
}

// array methods and properties
array.randomElement()! // it return new
