//
//  HomeSheet.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import Foundation

enum HomeSheet: Identifiable {
    case filter
    case add
//    case edit(id: String)
    
    var id: String {
        switch self {
        case .filter: "filter"
        case .add: "add"
//        case .edit(let id): "edit-\(id)"
        }
    }
}
