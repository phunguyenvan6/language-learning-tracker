//
//  HeaderView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 28/5/26.
//

import SwiftUI

struct HeaderView: View {
    let name: String
    
    var body: some View {
        HStack {
            Text("Chào \(name.uppercased())")
                .padding(.vertical, AppSpacing.sm)
                .background(AppColor.bgPrimary)
                .font(AppTypography.title)
                .foregroundStyle(.linearGradient(colors: [AppColor.brandPrimary, AppColor.brandSecondary], startPoint: .leading, endPoint: .trailing))
                .multilineTextAlignment(.center)
            Spacer()
            Image(systemName: "bell.fill")
                .font(AppTypography.title)
                .foregroundStyle(AppColor.textSecondary)
        }
        .padding(.vertical, AppSpacing.sm)
    }
}

#Preview("Header") {
    HeaderView(name: "Phú")
        .padding()
}
