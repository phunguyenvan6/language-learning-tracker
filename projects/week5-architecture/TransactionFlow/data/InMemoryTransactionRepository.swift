//
//  InMemoryTransactionRepository.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 15/6/26.
//

import Foundation

final class InMemoryTransactionRepository: TransactionRepository {
    private var transactions: [Transaction] = []
    
    func fetchAll() -> [Transaction] {
        transactions
    }
    
    func save(_ transaction: Transaction) throws {
        try validate(transaction)
        transactions.append(transaction)
    }
    
    func update(_ transaction: Transaction) throws {
        guard let index = transactions.firstIndex(where: {$0.id == transaction.id}) else {
            return
        }
        try validate(transaction)
        transactions[index] = transaction
    }
    
    func delete(id: String) {
        transactions.removeAll { $0.id == id }
    }
    
    private func validate(_ transaction: Transaction) throws {
        guard transaction.amount > 0 else {
            throw TransactionError.invalidAmount
        }
    }

}
