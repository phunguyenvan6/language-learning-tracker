//
//  TransactionFlowApp.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

@main
struct TransactionFlowApp: App {
    @State private var store = TransactionStore(repository: InMemoryTransactionRepository())

    var body: some Scene {
        WindowGroup {
            AppRouterView().environment(store)
        }
    }
}
