//
//  EmptyTransactionsView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 1/6/26.
//

import SwiftUI

struct EmptyTransactionsView: View {
    let onRefresh: () -> Void
    
    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            Image(systemName: "tray")
                .font(.system(size: 40))
                .foregroundStyle(AppColor.textSecondary)
            Text("Chưa có giao dịch")
                .font(AppTypography.headline)
                .foregroundStyle(AppColor.textPrimary)
            Text("Các giao dịch của bạn sẽ hiển thị tại đây.")
                .font(AppTypography.body)
                .foregroundStyle(AppColor.textSecondary)
                .multilineTextAlignment(.center)
            Button(action: onRefresh) {
                Label("Làm mới", systemImage: "arrow.clockwise")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColor.brandPrimary)
            }
            .buttonStyle(.plain)
            .padding(.top, AppSpacing.md)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.xl)
    }
}

#Preview {
    EmptyTransactionsView {
        
    }
    .padding()
    .background(AppColor.bgPrimary)
}

#Preview("Dark") {
    EmptyTransactionsView {
        
    }
    .padding()
    .background(AppColor.bgPrimary)
    .preferredColorScheme(.dark)
}
