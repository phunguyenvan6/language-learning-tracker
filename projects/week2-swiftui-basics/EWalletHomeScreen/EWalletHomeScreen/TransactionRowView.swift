//
//  TransactionRowView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 28/5/26.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(transaction.displayNote) - \(transaction.displayAmount)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(AppTypography.body)
                .foregroundStyle(
                    .linearGradient(
                        colors: [
                            AppColor.brandPrimary, AppColor.brandSecondary
                        ], startPoint: .leading, endPoint: .trailing
                    )
                )
        }
    }
}

#Preview("Transaction Row") {
    TransactionRowView(
        transaction: Transaction(
            id: "preview-1",
            amount: 1_500_000,
            note: "Đi chợ",
            category: .shopping,
            createAt: Date()
        )
    )
    .padding()
}
