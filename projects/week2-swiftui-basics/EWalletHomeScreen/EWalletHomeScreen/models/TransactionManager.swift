//
//  TransactionManager.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

import Foundation

final class TransactionManager {
    private(set) var transactions: [Transaction] = []
    
    func add(_ transaction: Transaction) throws {
        try validate(transaction)
        transactions.append(transaction)
    }
    
    func add(amount: Double, note: String?, category: TransactionCategory) throws {
        let transaction = Transaction(id: UUID().uuidString, amount: amount, note: note, category: category, createAt: Date())
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
        transactions.sorted { $0.createAt > $1.createAt }
    }
    
    func totalAmount() -> Double {
        transactions.reduce(0) { $0 + $1.amount }
    }
}

func validate(_ transaction: Transaction) throws {
    guard transaction.amount > 0 else {
        throw TransactionError.invalidAmount
    }
}
