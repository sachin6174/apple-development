//
//  Solid.swift
//  SwiftUILearning
//
//  Created by sachin kumar on 18/03/25.
//

import Foundation

// 5 code architectures principles that , when applied together, intend  to make it more likely that a programmar will create a system that is easy to maintain and extand over time.

//S -> Single Responsibility Principle (SRP)
//O open/Closed Principle (OCP)
//L Liskov Substitution principle (LSP)
//I Interface Segregaation Principle (ISP)
//D Dependency Inversion Principle (DIP)



//S -> Single Responsibility Principle (SRP)
/*
 A class should only be responsible for one thing
 */
struct Product {
    let price: Double
}

//struct Invoice {
//    var products: [Product] = []
//    let id = NSUUID().uuidString
//    var discountPercentage : Double = 0
//    
//    var total : Double {
//        let total = products.map({$0.price}).reduce(0, {$0 + $1})
//        let discountedAmount = total * (discountPercentage / 100)
//        return total - discountedAmount
//    }
//    
//    func printInvoice() {
//        print(id , total , discountPercentage)
//    }
//    
//    func saveInvoice() {
//        
//    }
//    
//}

let products : [Product] = [
    .init(price: 99),
    .init(price: 9),
    .init(price: 9)
]

let invoice = Invoice(products: products,discountPercentage : 20)
invoice.printInvoice()


// Refactored code

struct InvoicePersistance{
    let invoice : Invoice
    func saveInvoice() {
        // save persistance code
        
    }
}


struct InvoicePrinter {
    let invoice : Invoice
    func printInvoice() {
        print(invoice.id , invoice.total , invoice.discountPercentage)
    }
}




let invoice2 = Invoice(products: products,discountPercentage : 20)
let printer = InvoicePrinter(invoice: invoice2)
let persistance = InvoicePersistance(invoice: invoice2)
printer.printInvoice()
persistance.saveInvoice()


// better way to implement Single Responsibility Principle (SRP)
struct Invoice {
    var products: [Product] = []
    let id = NSUUID().uuidString
    var discountPercentage : Double = 0
    
    var total : Double {
        let total = products.map({$0.price}).reduce(0, {$0 + $1})
        let discountedAmount = total * (discountPercentage / 100)
        return total - discountedAmount
    }
    
    func printInvoice() {
        let printer = InvoicePrinter(invoice: self)
        printer.printInvoice()
    }
    
    func saveInvoice() {
        let persistance = InvoicePersistance(invoice: self)
        persistance.saveInvoice()
    }
    
}


let invoice3 = Invoice(products: products,discountPercentage : 20)
invoice3.printInvoice()
invoice3.saveInvoice()





//O open/Closed Principle (OCP)
/*
 software entities (class ,module ,functions, etc ) should be open for extensions ,but closed for modification.
 In other words ,we can add additional functionality (extensions) without touching the existing code (modification of the object)
 */


// i can not touch Int class
extension Int {
    func squared()-> Int{
        return self*self
    }
}
var num = 10
num.squared()




struct InvoicePersistanceNew{
    let invoice : Invoice
    func saveInvoice() {
        // save persistance code
        
    }
}