//
//  QuickActionButton.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 1/6/26.
//

import SwiftUI

struct QuickActionButton: View {
    let title: String
    let systemImage: String
    let isProminent: Bool
    let action: () -> Void
    
    init(
        title: String,
        systemImage: String,
        isProminent: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.isProminent = isProminent
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xs) {
                Image(systemName: systemImage)
                    .font(isProminent ? .title : .title2)
                    .foregroundStyle(
                        isProminent ? .white : AppColor.brandPrimary
                    )
                    .frame(width: 52, height: 52)
                    .background {
                        if isProminent
                        {
                            Circle().fill(AppColor.brandPrimary)
                        }
                    }
                    .accessibilityHidden(true)
                Text(title)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColor.textPrimary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}

#Preview {
    HStack {
        QuickActionButton(title: "QR", systemImage: "qrcode",isProminent:true, action: {})
        QuickActionButton(title: "Chuyển tiền", systemImage: "arrow.left.arrow.right",isProminent: false, action: {})
    }
    .padding()
}
