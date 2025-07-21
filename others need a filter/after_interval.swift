let date = Date.now.addingTimeInterval(5)
let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
RunLoop.main.add(timer, forMode: .common)