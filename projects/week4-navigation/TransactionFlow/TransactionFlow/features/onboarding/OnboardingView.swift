//
//  OnboardingView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct OnboardingView: View {
    let onFinish: () -> Void
    var body: some View {
        ZStack {
            AppColor.bgPrimary.ignoresSafeArea()
            VStack(spacing: AppSpacing.xl) {
                Spacer()
                
                Image(systemName: "wallet.pass.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(AppColor.brandPrimary)
                
                Text("Chào mừng đến Transaction Flow")
                    .font(AppTypography.title)
                    .multilineTextAlignment(.center)
                
                Text("Đây là fullScreenCover - không swipe xuống được\nBấm nút bên dưới để đóng")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColor.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, AppSpacing.xl)
                
                Spacer()
                
                Button("Bắt đầu") {
                    onFinish()
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, AppSpacing.xl)
            }
            .padding(AppSpacing.lg)
        }
    }
}

#Preview {
    OnboardingView(onFinish: {})
}
