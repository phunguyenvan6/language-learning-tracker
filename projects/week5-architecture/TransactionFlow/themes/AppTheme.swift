//
//  AppTheme.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 1/6/26.
//

import SwiftUI

enum AppColor {
    static let bgPrimary = Color("bg.primary")
    static let bgCard = Color("bg.card")
    static let textPrimary = Color("text.primary")
    static let textSecondary = Color("text.secondary")
    static let textPrimaryWhite = Color("text.primaryWhite")
    static let brandPrimary = Color("brand.primary")
    static let brandSecondary = Color("brand.secondary")
    static let accentSuccess = Color("accent.success")
}

enum AppSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
}

enum AppRadius {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let card: CGFloat = 16
    static let pill: CGFloat = 999
}

enum AppTypography {
    static let title = Font.title2.weight(.bold)
    static let headline = Font.headline
    static let body = Font.body
    static let caption = Font.caption
}

enum AppShadow {
    struct Style {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
    
    static let card = Style(
        color: .black.opacity(0.1),
        radius: 10,
        x: 0,
        y: 10
    )
}

struct FormFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, AppSpacing.lg)
            .padding(.vertical, AppSpacing.md)
            .background(AppColor.bgCard, in: .rect(cornerRadius: AppRadius.md))
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.md)
                    .strokeBorder(AppColor.textSecondary.opacity(0.15), lineWidth: 1)
            )
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.lg)
            .background(
                LinearGradient(
                    colors: [AppColor.brandPrimary, AppColor.brandSecondary], startPoint: .topLeading, endPoint: .bottomTrailing
                ),
                in: .rect(cornerRadius: AppRadius.card)
            )
            .opacity(isEnabled ? 1 : 0.4)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .appShadow(AppShadow.card)
            .animation(.snappy(duration: 0.15), value: configuration.isPressed)
    }
}

extension View {
    func appShadow(_ style: AppShadow.Style) -> some View {
        shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }
    func formField() -> some View {
        modifier(FormFieldModifier())
    }
}
