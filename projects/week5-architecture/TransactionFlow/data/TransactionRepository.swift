//
//  TransactionRepository.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 15/6/26.
//

import Foundation

protocol TransactionRepository {
    func fetchAll() -> [Transaction]
    func save(_ transaction: Transaction) throws
    func update(_ transaction: Transaction) throws
    func delete(id: String)
}
