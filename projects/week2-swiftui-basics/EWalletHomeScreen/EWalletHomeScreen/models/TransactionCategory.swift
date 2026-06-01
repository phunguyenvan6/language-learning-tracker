//
//  TransactionCategory.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

enum TransactionCategory: String, Equatable {
    case food = "Food"
    case shopping = "Shopping"
    case transport = "Transport"
    case bill = "Bill"
}

extension TransactionCategory {
    var title: String {
        rawValue
    }
}
