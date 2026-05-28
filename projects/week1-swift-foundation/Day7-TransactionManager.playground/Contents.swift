import Foundation

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

enum TransactionError: Error, LocalizedError {
    case invalidAmount
    case emptyList
    
    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return "Số tiền không hợp lệ"
        case .emptyList:
            return "Không có giao dịch nào"
        }
    }
}

func validateAmount(_ amount: Double) throws {
    guard amount > 0 else {
        throw TransactionError.invalidAmount
    }
}

struct Transaction: Identifiable, Equatable {
    let id: String
    var amount: Double
    var note: String?
    var category: TransactionCategory
    var createdAt: Date
}

extension Transaction {
    var displayNote: String {
        note ?? "Không có ghi chú"
    }
    
    var displayAmount: String {
        amount.asVND()
    }
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

final class TransactionManager {
    private(set) var transactions: [Transaction] = []

    func add(_ transaction: Transaction) throws {
        try validateAmount(transaction.amount)
        transactions.append(transaction)
    }
    
    func add(amount: Double, note: String?, category: TransactionCategory) throws {
        try validateAmount(amount)
        
        let transaction = Transaction(
            id: UUID().uuidString,
            amount: amount,
            note: note,
            category: category,
            createdAt: Date()
        )
        transactions.append(transaction)
    }
    
    func delete(id: String) {
        transactions.removeAll { $0.id == id}
    }
    
    func update(_ tx: Transaction) throws {
        guard let index = transactions.firstIndex(where: { $0.id == tx.id })
        else {
            return
        }
        
        try validateAmount(tx.amount)
        transactions[index] = tx
    }
    
    func filter(by category: TransactionCategory) -> [Transaction] {
        transactions.filter { $0.category == category }
    }
    
    func sortByNewest() -> [Transaction] {
        transactions.sorted {
            $0.createdAt > $1.createdAt
        }
    }
    
    func totalAmount() -> Double {
        transactions.reduce(0) {
            $0 + $1.amount
        }
    }
    
    func printSummary() {
        let list = sortByNewest()
        
        print("Count: \(transactions.count)")
        print("Total: \(totalAmount().asVND())")
        if list.isEmpty {
          print("Không có giao dịch")
          return
        }
        print("--- Danh sách (mới nhất trước) ---")
        for tx in list {
          print("\(tx.displayNote): \(tx.displayAmount) - \(tx.category.title)")
        }
    }
}

// Playground: gom code chạy thử vào một hàm — tránh lỗi parse chung chung ở top-level.
func runDay7Demo() {
    let t1 = Transaction(id: UUID().uuidString, amount: 50000, note: "Coffee House", category: .food, createdAt: Date().addingTimeInterval(-3600))
    let t2 = Transaction(id: UUID().uuidString, amount: 120000, note: "Lunch at Homestay", category: .food, createdAt: Date())
    let t3 = Transaction(id: UUID().uuidString, amount: 2500000, note: "Transfer by Bus", category: .transfer, createdAt: Date())
    let t4 = Transaction(id: UUID().uuidString, amount: -100000, note: nil, category: .bill, createdAt: Date())
    let t5 = Transaction(id: UUID().uuidString, amount: 3500000, note: "Transfer by Airline", category: .transfer, createdAt: Date())

    let manager = TransactionManager()
    do {
        try manager.add(t1)
    } catch let error as TransactionError {
        print(error.errorDescription ?? "Lỗi không xác định")
    } catch {
        print("Lỗi khác: \(error)")
    }
    do {
        try manager.add(t2)
    } catch let error as TransactionError {
        print(error.errorDescription ?? "Lỗi không xác định")
    } catch {
        print("Lỗi khác: \(error)")
    }
    do {
        try manager.add(t3)
    } catch let error as TransactionError {
        print(error.errorDescription ?? "Lỗi không xác định")
    } catch {
        print("Lỗi khác: \(error)")
    }
    do {
        try manager.add(t4)
    } catch let error as TransactionError {
        print(error.errorDescription ?? "Lỗi không xác định")
    } catch {
        print("Lỗi khác: \(error)")
    }
    do {
        try manager.add(t5)
    } catch let error as TransactionError {
        print(error.errorDescription ?? "Lỗi không xác định")
    } catch {
        print("Lỗi khác: \(error)")
    }
    do {
        try manager.add(t5)
    } catch let error as TransactionError {
        print(error.errorDescription ?? "Lỗi không xác định")
    } catch {
        print("Lỗi khác: \(error)")
    }
    
    
    manager.printSummary()
    
    let newT3 = Transaction(id: t3.id, amount: 1500000, note: "Transfer by Airplain", category: .transfer, createdAt: Date())
    
    do {
        try     manager.update(newT3)

    } catch let error as TransactionError {
        print(error.errorDescription ?? "Lỗi không xác định")
    } catch {
        print("Lỗi khác: \(error)")
    }
    
    print("T3 updated with new total: \(manager.totalAmount().asVND())")
    
    manager.delete(id: t3.id)
    print("Count: \(manager.transactions.count)")
}

runDay7Demo()
