//
//  ContentView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

import SwiftUI

struct ContentView: View {
    private let sampleTransaction = Transaction(id: UUID().uuidString, amount: 1500000, note: "Đi chợ", category: .shopping, createAt: Date())
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(name: "Phú")
            BalanceCard(balance: 15000000.0)
            VStack(alignment: .leading) {
                Text("Giao dịch gần đây:")
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                    .font(.headline)
                TransactionRowView(transaction: sampleTransaction)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}

#Preview("Có số dư") {
    ContentView()
}

#Preview("Dark") {
    ContentView().preferredColorScheme(.dark)
}
