//
//  TransactionManager.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

import Foundation
import Observation

// @Observable đủ vì TransactionFlowApp giữ @State manager; body tự re-render khi property thay đổi.
//State là owner sở hữu instance tránh tạo nhiều lần.

@Observable
final class TransactionManager {
    private(set) var transactions: [Transaction] = []
    
    func add(_ transaction: Transaction) throws {
        try validate(transaction)
        transactions.append(transaction)
    }
    
    func add(amount: Double, note: String?, category: TransactionCategory) throws {
        let transaction = Transaction(id: UUID().uuidString, amount: amount, note: note, category: category, createdAt: Date())
        try validate(transaction)
        
        transactions.append(transaction)
    }
   
    func add(amount: Double, note: String?, category: TransactionCategory, createdAt: Date) throws {
        let transaction = Transaction(id: UUID().uuidString, amount: amount, note: note, category: category, createdAt: createdAt)
        try validate(transaction)
        
        transactions.append(transaction)
    }
    
    func delete(id: String) {
        transactions.removeAll { $0.id == id}
    }
    
    func update(_ tx: Transaction) throws {
        guard let index = transactions.firstIndex(where:  { $0.id == tx.id }) else { return }
        
        try validate(tx)
        transactions[index] = tx
    }
    
    func filter(by category: TransactionCategory) -> [Transaction] {
        transactions.filter { $0.category == category }
    }
    
    func sortByNewest() -> [Transaction] {
        transactions.sorted { $0.createdAt > $1.createdAt }
    }
    
    func sortByAmount() -> [Transaction] {
        transactions.sorted { $0.amount < $1.amount }
    }
    
    func totalAmount() -> Double {
        transactions.reduce(0) { $0 + $1.amount }
    }
    
    private func validate(_ transaction: Transaction) throws {
        guard transaction.amount > 0 else {
            throw TransactionError.invalidAmount
        }
    }
}

extension TransactionManager {
    static func previewSeeded() -> TransactionManager {
        let manager = TransactionManager()
        let samples: [(Double, String?, TransactionCategory, TimeInterval)] = [
            (50_000, "Cà phê", .food, -3600),
            (120_000, "Siêu thị", .shopping, -7200),
            (35_000, "Grab", .transport, -86400),
        ]
        for sample in samples {
            try? manager.add(
                amount: sample.0,
                note: sample.1,
                category: sample.2,
                createdAt: Date().addingTimeInterval(sample.3)
            )
        }
        return manager
    }
}
