//
//  Transaction.swift
//  AddTransactionForm
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
        "\(Self.vndFormatter.string(from: NSNumber(value: amount)) ?? "\(amount)") VND"
    }
    
    private static let relativeDateFormatter: RelativeDateTimeFormatter = {
        let f = RelativeDateTimeFormatter()
        f.locale = Locale(identifier: "vi_VN")
        f.unitsStyle = .full
        f.dateTimeStyle = .named
        return f
    }()
    
    private static let vndFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = ","
        f.maximumFractionDigits = 0
        return f
    }()
    
    var displayRelativeDate: String {
        Self.relativeDateFormatter.localizedString(for: createdAt, relativeTo: Date())
    }
}
