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
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                HStack {
                    Text("Số dư hiện tại:")
                        .font(AppTypography.title)
                        .foregroundStyle(.white)
                    Spacer()
                    Text("VIB Wallet")
                        .foregroundStyle(AppColor.textPrimaryWhite)
                        .font(.caption)
                        .padding(.horizontal, AppSpacing.sm)
                        .padding(.vertical, AppSpacing.xs)
                        .background(AppColor.brandPrimary.opacity(0.15))
                        .clipShape(Capsule())
                    
                }
                Text (balance.asVND())
                    .font(AppTypography.title)
                    .foregroundStyle(.white)
            }
            .padding(AppSpacing.lg)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
                    .fill(
                        .linearGradient(
                            .init(
                                colors:
                                    [
                                    AppColor.brandPrimary,
                                    AppColor.brandPrimary.opacity(0.3),
                                    AppColor.brandPrimary.opacity(0.2)
                                ]
                            ),
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
            }
            Image(systemName: "creditcard.fill")
                .font(AppTypography.title)
                .foregroundStyle(AppColor.textPrimaryWhite)
                .padding(.bottom, AppSpacing.lg)
                .padding(.trailing, AppSpacing.lg)
        }
        .appShadow(AppShadow.card)
    }
}

#Preview("Balance Card") {
    BalanceCard(balance: 15_000_000)
        .padding()
}

#Preview("Balance Card Dark") {
    BalanceCard(balance: 15_000_000)
        .padding().preferredColorScheme(.dark)
}
