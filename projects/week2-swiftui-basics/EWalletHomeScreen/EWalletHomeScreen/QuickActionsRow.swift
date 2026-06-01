//
//  QuickActionRow.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 1/6/26.
//

import SwiftUI

struct QuickActionsRow: View {
    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            QuickActionButton(title: "Nạp tiền", systemImage: "plus.circle.fill") {
                print("Nạp tiền tapped")
            }
            QuickActionButton(title: "Chuyển tiền", systemImage: "arrow.left.arrow.right.circle") {
                print("Chuyển tiền tapped")
            }
            QuickActionButton(title: "QR", systemImage: "qrcode", isProminent: true ) {
                print("QR tapped")
            }
            QuickActionButton(title: "Thanh toán", systemImage: "creditcard.fill") {
                print("Thanh toán tapped")
            }
        }
    }
}

#Preview("Quick actions") {
    QuickActionsRow()
        .padding()
}

#Preview("Quick actions dark") {
    QuickActionsRow()
        .padding().preferredColorScheme(.dark)
}
