@Published var text: String = "Hello"
Without @Published, changing text won’t notify SwiftUI, so your UI wouldn’t update automatically.
