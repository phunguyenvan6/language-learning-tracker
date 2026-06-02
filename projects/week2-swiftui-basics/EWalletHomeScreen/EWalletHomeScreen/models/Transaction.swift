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
    var createdAt: Date
}

extension Transaction {
    var displayNote: String {
        note ?? "Không có ghi chú"
    }
    
    var displayAmount: String {
        amount.asVND()
    }
    
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        formatter.locale = Locale(identifier: "vi_VN")
        return formatter.string(from: createdAt)
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
