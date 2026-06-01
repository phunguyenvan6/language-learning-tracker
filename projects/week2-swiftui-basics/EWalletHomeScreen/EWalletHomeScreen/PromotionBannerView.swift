//
//  PromotionBannerView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 1/6/26.
//

import SwiftUI

struct PromotionBannerView: View {
    let title: String
    let description: String
    let ctaTitle: String
    
    private let bannerHeight: CGFloat = 120
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                Image("banner")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(height: bannerHeight)
                    .frame(maxWidth: .infinity)
                Text("Thời gian có hạn")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColor.textPrimary)
                    .padding(.vertical, AppSpacing.sm)
                    .padding(.horizontal, AppSpacing.sm)
                    .background(
                        UnevenRoundedRectangle(
                            bottomTrailingRadius: AppRadius.card
                        ).fill(
                            AppColor.bgCard
                        )
                    )
            }
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "gift.fill")
                            .foregroundStyle(AppColor.textPrimary)
                            .font(AppTypography.title)
                        Text(title)
                            .foregroundStyle(AppColor.textPrimary)
                            .font(AppTypography.title)
                    }
                    Text(description)
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColor.textSecondary)
                }
                .padding(.trailing, AppSpacing.xs)
                Spacer()
                Button {
                    print("Xem ngay")
                } label: {
                    Text(ctaTitle)
                        .foregroundStyle(AppColor.textPrimaryWhite)
                        .padding(.vertical, AppSpacing.xs)
                        .padding(.horizontal, AppSpacing.md)
                }
                .background(
                    RoundedRectangle(
                        cornerRadius: AppRadius.sm, style: .continuous
                    )
                    .fill(AppColor.brandSecondary)
                )
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, AppSpacing.sm)
            .padding(.horizontal, AppSpacing.sm)
            .background(AppColor.bgCard)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .clipShape(
            RoundedRectangle(cornerRadius: AppRadius.card, style: .continuous)
        )
        .appShadow(AppShadow.card)
        .accessibilityLabel("Banner khuyến mãi")
    }
    
}

#Preview("Banner") {
    PromotionBannerView(
        title: "Hoàn tiền đến 5%", description: "Thanh toán hoá đơn qua VIB Wallet", ctaTitle: "Xem ngay"
    )
    .padding()
}

#Preview("Banner dark") {
    PromotionBannerView(
        title: "Hoàn tiền đến 5%", description: "Thanh toán hoá đơn qua VIB Wallet", ctaTitle: "Xem ngay"
    )
    .padding()
    .preferredColorScheme(.dark)
}
