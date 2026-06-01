//
//  BalanceCard.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 28/5/26.
//

import SwiftUI

struct BalanceCard: View {
    let balance: Double
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Số dư hiện tại:").font(.title2).fontWeight(.semibold).foregroundStyle(.white)
                    Spacer()
                    Text("VIB Wallet")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.blue.opacity(0.15))
                        .clipShape(Capsule())

                }
                Text (balance.asVND()).font(.title2).bold().foregroundStyle(.white)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.linearGradient(
                        .init(colors: [Color.blue, .blue.opacity(0.3), .blue.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            Image(systemName: "wallet.pass.fill")
                .font(.title2)
                .foregroundStyle(.blue.opacity(0.3))
                .padding(.bottom, 16)
                .padding(.trailing, 16)
        }
    }
}

#Preview("Balance Card") {
    BalanceCard(balance: 15_000_000)
        .padding()
}
