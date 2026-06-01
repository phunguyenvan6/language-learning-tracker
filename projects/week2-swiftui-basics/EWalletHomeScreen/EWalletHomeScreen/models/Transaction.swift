//
//  Transaction.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

import Foundation

struct Transaction: Identifiable, Equatable {
    let id: String
    var amount: Double
    var note: String?
    var category: TransactionCategory
    var createAt: Date
}

extension Transaction {
    var displayNote: String {
        note ?? "Không có ghi chú"
    }
    
    var displayAmount: String {
        amount.asVND()
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
