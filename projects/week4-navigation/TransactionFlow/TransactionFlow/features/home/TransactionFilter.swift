//
//  TransactionFilter.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import Foundation

struct TransactionFilter: Equatable {
    var category: TransactionCategory?
    var fromDate: Date?
    var toDate: Date?
    
    static let empty = TransactionFilter()
    
    var isActive: Bool { self != .empty }
    
    var totalFilter: Int {
        var count = 0
        if self.fromDate != nil {
            count += 1
        }
        if self.toDate != nil {
            count += 1
        }
        if self.category != nil {
            count += 1
        }
        return count
    }
}
