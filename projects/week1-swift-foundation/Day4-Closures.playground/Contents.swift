import Cocoa

func formatAmount (_ amount: Double) -> String {
    "\(amount) VND"
}

func formatAmountWithSymbol(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    formatter.maximumFractionDigits = 0
    let formatted = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    return "\(formatted) VND"
}

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

func filterTransactions(_ transactions: [Transaction], by category: TransactionCategory ) -> [Transaction] {
    transactions.filter{ $0.category == category }
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
        transactions.count == 0 ? print("No transaction") : transactions.forEach { print("\(displayNote($0.note)): \(formatAmountWithSymbol($0.amount))") }
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

func handleAmount(callback: (Double)-> Void) {
    callback(100_000)
}

handleAmount {
    amount in print(amount)
}

func performTransaction(
    amount: Double,
    onSuccess: (String) -> Void,
    onError: (String) -> Void
) {
    if amount > 0 {
        onSuccess("Success: \(formatAmountWithSymbol(amount))")
    } else {
        onError("Failed: Invalid amount")
    }
}

performTransaction(
    amount: t1.amount,
    onSuccess: { success in
        print(success)
    },
    onError: { error in
        print(error)
    }
)

performTransaction(
    amount: t4.amount,
    onSuccess: { success in
        print(success)
    },
    onError: { error in
        print(error)
    }
)


func simulatePayment(amount: Double, note : String?, onComplete: (String) -> Void) {
    onComplete("Payment completed: \(formatAmountWithSymbol(amount)) - \(displayNote(note))")
}

let t6 = Transaction(id: "6", amount: 500000, note: "Transfer by Airline", category: .transfer)


simulatePayment(amount: t6.amount, note: t6.note) {
    text in
        print(text)
        store.add(t6)
}

simulatePayment(amount: 10_000, note: nil) { print($0) }
