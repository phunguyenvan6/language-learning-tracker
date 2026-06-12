//
//  TransactionError.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

import Foundation

enum TransactionError: Error, LocalizedError {
    case invalidAmount
    
    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return "Số tiền không hợp lệ"
        }
    }
}
