//
//  AppRouterView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct AppRouterView: View {
    @State private var path: [AppRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(
                onOpenTransaction: { id in
                    path.append(.transactionDetail(id: id))
                },
                onAddTransaction: {
                    path.append(.addTransaction)
                }
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .home:
                    EmptyView()
                case .transactionDetail(let id):
                    TransactionDetailView(transactionId: id)
                case .addTransaction:
                    AddTransactionView()
                }
                
            }
        }
    }
}
