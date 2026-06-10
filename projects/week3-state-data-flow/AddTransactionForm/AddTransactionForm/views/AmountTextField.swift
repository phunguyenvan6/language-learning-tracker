//
//  AmountTextField.swift
//  AddTransactionForm
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 10/6/26.
//

import SwiftUI

struct AmountTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: AppSpacing.md) {
            Text("₫")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(isFocused ? AppColor.brandPrimary : AppColor.textSecondary)
            TextField("0", text: $text)
                .keyboardType(.decimalPad)
                .font(.system(.title, design: .rounded).bold())
                .focused($isFocused)
        }
        .padding(AppSpacing.lg)
        .background(AppColor.bgCard, in: .rect(cornerRadius: AppRadius.md))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.md)
                .strokeBorder(
                    isFocused ? AppColor.brandPrimary : AppColor.textSecondary.opacity(0.15),
                    lineWidth: isFocused ? 2 : 1
                )
        )
        .animation(.snappy(duration: 0.2), value: isFocused)
    }
}

#Preview {
    @Previewable @State var amountText = "50000"

    AmountTextField(text: $amountText)
        .padding()
}
