//
//  TransactionStore.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 16/6/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class TransactionStore {
    private(set) var transactions: [Transaction] = []
    private(set) var appliedFilter: TransactionFilter = .empty
    
    private let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
        load()
    }
    
    func load() {
        transactions = repository.fetchAll()
    }
    
    func add(amount: Double, note: String?, category: TransactionCategory, createdAt: Date) throws {
        let transaction = Transaction(id: UUID().uuidString, amount: amount, note: note, category: category, createdAt: createdAt)
        
        try repository.save(transaction)
        load()
    }
    
    func delete(id: String) {
        repository.delete(id: id)
        load()
    }

    func update(_ transaction: Transaction) throws {
        try repository.update(transaction)
        load()
    }

    func transaction(id: String) -> Transaction? {
        transactions.first { $0.id == id }
    }
    
    var displayedTransactions: [Transaction] {
        var result = transactions.sorted { $0.createdAt > $1.createdAt }

        if let category = appliedFilter.category {
            result = result.filter { $0.category == category }
        }
        if let from = appliedFilter.fromDate {
            result = result.filter {
                Calendar.current.startOfDay(for: $0.createdAt) >= Calendar.current.startOfDay(for: from)
            }
        }
        if let to = appliedFilter.toDate {
            result = result.filter {
                Calendar.current.startOfDay(for: $0.createdAt) <= Calendar.current.startOfDay(for: to)
            }
        }
        return result
    }
    
    var isEmpty: Bool {
        transactions.isEmpty
    }
    var isFilterActive: Bool {
        appliedFilter.isActive
    }

    func applyFilter(_ filter: TransactionFilter) {
        appliedFilter = filter
    }
    
    func clearFilter() {
        appliedFilter = .empty
    }

}

extension TransactionStore {
    static func previewSeeded() -> TransactionStore {
        let store = TransactionStore(repository: InMemoryTransactionRepository())
        let samples: [(Double, String?, TransactionCategory, TimeInterval)] = [
            (850_000, "Đi chợ", .food, -41000),
            (2_500_000, "Chuyển tiền", .transport, -12000),
            (120_000, nil, .bill, -2000),
        ]
        for sample in samples {
            try? store.add(
                amount: sample.0,
                note: sample.1,
                category: sample.2,
                createdAt: Date().addingTimeInterval(sample.3)
            )
        }
        return store
    }
}
