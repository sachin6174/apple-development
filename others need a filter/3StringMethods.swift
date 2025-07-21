import Foundation

// Example string used for demonstration
let example = " Hello, World! Swift is Amazing. "

// 1. Count & Emptiness
print("Original String: [\(example)]")
print("Count (number of characters):", example.count)
print("Is Empty:", example.isEmpty)

// 2. Trimming Whitespace and Newlines
let trimmed = example.trimmingCharacters(in: .whitespacesAndNewlines)
print("Trimmed String: [\(trimmed)]")

// 3. Case Conversions
print("Uppercased:", example.uppercased())
print("Lowercased:", example.lowercased())
print("Capitalized:", example.capitalized)

// 4. Prefix and Suffix Checking
print("Has prefix ' Hello':", example.hasPrefix(" Hello"))
print("Has suffix ' Amazing. ':", example.hasSuffix(" Amazing. "))

// 5. Contains & Replacing Substrings
print("Contains 'World':", example.contains("World"))
let replaced = example.replacingOccurrences(of: "Swift", with: "Swift programming")
print("After replacing 'Swift':", replaced)

// 6. Splitting String into Substrings
let words = example.split(separator: " ")
print("Split by space:", words)
let components = example.components(separatedBy: ",")
print("Components separated by comma:", components)

// 7. Extracting Prefix and Suffix Substrings
let prefix5 = example.prefix(5)
let suffix5 = example.suffix(5)
print("Prefix 5 characters:", prefix5)
print("Suffix 5 characters:", suffix5)

// 8. Substring Using Index
if let index = example.firstIndex(of: "W") {
    let substringFromW = example[index...]
    print("Substring from 'W':", substringFromW)
}

// 9. Iterating Over Characters
print("Iterating over each character:")
for char in example {
    print(char, terminator: " ")
}
print()  // Newline

// 10. Enumerating String Indices
print("String Indices:")
for i in example.indices {
    print(i, terminator: " ")
}
print()

// 11. Dropping Characters
print("Drop first character:", example.dropFirst())
print("Drop last character:", example.dropLast())

// 12. Localized Case Conversions
print("Localized Uppercase:", example.localizedUppercase)
print("Localized Lowercase:", example.localizedLowercase)

// 13. Working with Unicode Scalars
print("Unicode Scalars:")
for scalar in example.unicodeScalars {
    print(scalar, terminator: " ")
}
print()

// 14. UTF8 and UTF16 Views
print("UTF8 view:")
for byte in example.utf8 {
    print(byte, terminator: " ")
}
print()

print("UTF16 view:")
for codeUnit in example.utf16 {
    print(codeUnit, terminator: " ")
}
print()

// 15. Accessing First and Last Characters
if let firstChar = example.first {
    print("First Character:", firstChar)
}
if let lastChar = example.last {
    print("Last Character:", lastChar)
}
