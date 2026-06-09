//
//  TransactionRowView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 28/5/26.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    let action: (String) -> Void
    
    var body: some View {
        Button {
            action(transaction.id)
        } label: {
            HStack(alignment: .center, spacing: AppSpacing.sm) {
                // Icon
                    Image(systemName: transaction.category.systemImage)
                        .font(.title3)
                        .foregroundStyle(AppColor.brandPrimary)
                        .frame(width: 44, height: 44)
                        .background(AppColor.bgCard)
                        .clipShape(RoundedRectangle(cornerRadius: AppRadius.sm))
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text(transaction.category.title)          // title
                            .font(AppTypography.headline)
                            .foregroundStyle(AppColor.textPrimary)
                        Text(transaction.displayNote)             // note
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColor.textSecondary)
                            .lineLimit(1)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: AppSpacing.xs) {
                        Text(transaction.displayAmount)           // amount
                            .font(AppTypography.headline)
                            .foregroundStyle(AppColor.textPrimary)
                        Text(transaction.displayRelativeDate)         // date
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColor.textSecondary)
                    }
            }
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
            createdAt: Date().addingTimeInterval(-45 * 60)
        )
    ) { id in
        print("Tapped:", id)
    }.padding()
}
