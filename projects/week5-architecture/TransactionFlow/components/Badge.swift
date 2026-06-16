//
//  Badge.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct Badge: View {
    enum Style {
        case brand
        case brandSoft
        case success
        case danger
        case neutral
    }

    enum Size {
        case compact
        case regular
    }

    private let text: String
    private let style: Style
    private let size: Size

    init(_ text: String, style: Style = .brandSoft, size: Size = .regular) {
        self.text = text
        self.style = style
        self.size = size
    }

    init(count: Int, style: Style = .danger, size: Size = .compact) {
        self.text = count > 99 ? "99+" : "\(count)"
        self.style = style
        self.size = size
    }

    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(minWidth: minDimension, minHeight: minDimension)
            .background(backgroundColor, in: Capsule())
    }

    private var font: Font {
        switch size {
        case .compact:
            AppTypography.caption.weight(.semibold)
        case .regular:
            AppTypography.caption
        }
    }

    private var horizontalPadding: CGFloat {
        size == .compact ? 0 : AppSpacing.sm
    }

    private var verticalPadding: CGFloat {
        size == .compact ? 0 : AppSpacing.xs
    }

    private var minDimension: CGFloat? {
        size == .compact ? AppSpacing.xl : nil
    }

    private var foregroundColor: Color {
        switch style {
        case .brand, .success, .danger:
            AppColor.textPrimaryWhite
        case .brandSoft:
            AppColor.textPrimaryWhite
        case .neutral:
            AppColor.textPrimary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .brand:
            AppColor.brandPrimary
        case .brandSoft:
            AppColor.brandPrimary.opacity(0.35)
        case .success:
            AppColor.accentSuccess
        case .danger:
            .red
        case .neutral:
            AppColor.bgCard
        }
    }
}

#Preview("Label badges") {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Badge("VIB Wallet")
        Badge("VIB Wallet", style: .brand)
        Badge("Đã lọc", style: .success)
        Badge("Thời gian có hạn", style: .neutral)
    }
    .padding()
    .background(AppColor.bgPrimary)
}

#Preview("Count badges") {
    HStack(spacing: AppSpacing.md) {
        Badge(count: 1)
        Badge(count: 12, style: .brand)
        Badge(count: 120, style: .success)
    }
    .padding()
    .background(AppColor.bgPrimary)
}
