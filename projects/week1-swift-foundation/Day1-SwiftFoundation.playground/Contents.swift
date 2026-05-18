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

struct Transaction {
    let id: String
    let amount: Double
    let note: String
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
        transactions.count == 0 ? print("No transaction") : transactions.forEach { print("\($0.note): \(formatAmountWithSymbol($0.amount))") }
    }
}

let store = TransactionStore()

let t1 = Transaction(id: "1", amount: 50000, note: "Coffee")
store.add(t1)
let t2 = Transaction(id: "2", amount: 120000, note: "Lunch")
store.add(t2)
let t3 = Transaction(id: "3", amount: 2500000, note: "Transfer")
store.add(t3)

store.printNotes()
print("---")
print("Total: \(formatAmountWithSymbol(store.totalAmount()))")

struct Transaction2 {
    let id: String
    var amount: Double
    let note: String
}

var transactionStretch: Transaction2 = Transaction2(
    id: "4", amount: 50000, note: "Lunch"
)
print(transactionStretch.amount)

var transactionStretch2 = transactionStretch
transactionStretch2.amount = 100000
print(transactionStretch.amount)
print(transactionStretch2.amount)

var store2 = TransactionStore()
var store3 = TransactionStore()
store2.add(t1)
store2.add(t2)
store2.add(t3)

store3 = store2

store3.transactions = []
print(store2.transactions.count)

