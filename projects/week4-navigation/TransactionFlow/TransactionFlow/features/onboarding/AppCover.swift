//
//  AppCover.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import Foundation

enum AppCover: Identifiable {
    case onboarding
    
    var id: String {
        switch self {
        case .onboarding: "onboarding"
        }
    }
}
