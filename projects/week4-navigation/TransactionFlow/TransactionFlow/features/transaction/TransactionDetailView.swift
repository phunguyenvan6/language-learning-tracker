//
//  TransactionDetailView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct TransactionDetailView: View {
    let transactionId: String
    
    @Environment(TransactionManager.self) private var manager
    @Environment(\.dismiss) private var dismiss
    
    private var transaction: Transaction? {
        manager.transactions.first { $0.id == transactionId }
    }
    
    var body: some View {
        VStack {
            if let tx = transaction {
                LabeledContent("Số tiền", value: tx.displayAmount)
                LabeledContent("Danh mục", value: tx.category.title)
                LabeledContent("Ghi chú", value: tx.displayNote)
                LabeledContent("Thời gian", value: tx.displayRelativeDate)
            } else {
                ContentUnavailableView(
                    "Không tìm thấy",
                    systemImage: "exclamationmark.triangle"
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    manager.delete(id: transactionId)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 8)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Chi tiết")
    }
}
