import Foundation

func displayNote(_ note: String?) -> String {
    note ?? "Không có ghi chú"
}

enum TransactionCategory: String, Equatable {
    case food = "Food"
    case shopping = "Shopping"
    case transfer = "Transfer"
    case bill = "Bill"
}


extension TransactionCategory {
    var title: String {
        rawValue
    }
}

struct Transaction {
    let id: String
    let amount: Double
    let note: String?
    let category: TransactionCategory
}

extension Array where Element == Transaction {
    var totalAmount: Double {
        reduce(0) { $0 + $1.amount }
    }
}

extension Double {
    func asVND() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 0
        let formatted = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        return "\(formatted) VND"
    }
}

final class TransactionStore {
    var transactions: [Transaction] = []
    
    func add(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    func totalAmount() -> Double {
        transactions.reduce(0) { $0 + $1.amount }
    }
    
    func printNotes() {
        transactions.count == 0 ? print("No transaction") : transactions.forEach { print("\(displayNote($0.note)): \($0.amount.asVND())") }
    }
}

let store = TransactionStore()

let t1 = Transaction(id: "1", amount: 50000, note: "Coffee House", category: .food)
store.add(t1)
let t2 = Transaction(id: "2", amount: 120000, note: "Lunch at Homestay", category: .food)
store.add(t2)
let t3 = Transaction(id: "3", amount: 2500000, note: "Transfer by Bus", category: .transfer)
store.add(t3)
let t4 = Transaction(id: "4", amount: -100000, note: nil, category: .bill)
store.add(t4)
let t5 = Transaction(id: "5", amount: 3500000, note: "Transfer by Airline", category: .transfer)
store.add(t5)

protocol TransactionRepository {
    func getTransactions() -> [Transaction]
}

final class MockTransactionRepository: TransactionRepository {
    func getTransactions() -> [Transaction] {
        let apiResponse: ApiResponse<[Transaction]> = .init(data: [t1, t2, t3, t4, t5], message: "OK")
        print("API Items: \(apiResponse.data.count)")
        if apiResponse.data.isEmpty {
            return []
        }
        print(apiResponse.message ?? "")
        return apiResponse.data
    }
}

struct ApiResponse<T> {
    let data: T
    let message: String?
}

func printTransactionSummary(repository: TransactionRepository) {
    let list = repository.getTransactions()
    print("Count: \(list.count)")
    list.forEach {
        tx in print("\(displayNote(tx.note)): \(tx.amount.asVND()) - \(tx.category.title)")
    }
    print("Total: \(list.totalAmount.asVND())")
}

let repo = MockTransactionRepository()

printTransactionSummary(repository: repo)


