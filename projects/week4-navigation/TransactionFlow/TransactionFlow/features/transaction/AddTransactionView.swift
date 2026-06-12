//
//  AddTransactionView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Form thêm giao dịch - Day 2")
                .foregroundStyle(.secondary)
            Button("Quay lại") {
                dismiss()
            }
        }
        .navigationTitle("Thêm mới")
    }
}
