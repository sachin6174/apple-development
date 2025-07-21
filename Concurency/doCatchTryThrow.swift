🧩 Class Example
Student Class

class Student {
    private let manager: GetStudentData
    var data: String = "initial data"

    init(manager: GetStudentData = .init()) {
        self.manager = manager
    }

    func fetchData() {
        let data = manager.getData()
        if let data = data {
            self.data = data
        }
    }
}
GetStudentData Class

class GetStudentData {
    let fetchSuccess: Bool = true

    func getData() -> String? {
        if fetchSuccess {
            return "data"
        } else {
            return nil
        }
    }
}
📦 Tuple-based Error Handling

func getData2() -> (data: String?, error: Error?) {
    if fetchSuccess {
        return ("data", nil)
    } else {
        return (nil, URLError(.badURL))
    }
}
Usage:

let returnedValue = manager.getData2()
if let data = returnedValue.data {
    self.data = data
} else if let error = returnedValue.error {
    self.data = error.localizedDescription
}
🧱 Using Result Type

func getData3() -> Result<String, Error> {
    if fetchSuccess {
        return .success("data")
    } else {
        return .failure(URLError(.badURL))
    }
}
Usage:

let result = manager.getData3()
switch result {
case .success(let data):
    self.text = data
case .failure(let error):
    self.text = error.localizedDescription
}
⚠️ Throwing Errors
If you want to throw and let the caller handle:


func getData() throws -> String {
    if fetchSuccess {
        return "data"
    } else {
        throw URLError(.badServerResponse)
    }
}
Usage in do-catch block:

do {
    let data = try manager.getData()
    let newTitle = try manager.getTitle()
    let name = try manager.getTitle2()
} catch let error {
    self.data = error.localizedDescription
}
✅ Summary of Methods:
Method Type	Error Handling	Info Loss	Example
try?	Optional result	✅	let data = try? fetchData()
try!	Force unwrapping	✅⚠️	let data = try! fetchData()
do-try-catch	Full handling	❌	do { let data = try fetchData() }
Tuple (data, error)	Manual check	❌	(data, error) = fetchData2()
Result type	Safe & preferred	❌	switch fetchData() { ... }











