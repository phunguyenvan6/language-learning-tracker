//
//  TransactionListSection.swift
//  AddTransactionForm
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 11/6/26.
//

import SwiftUI

struct TransactionListSection: View {
    let transactions: [Transaction]
    let onRefresh: () -> Void
    let onTransactionTap: (String) -> Void
    
    @Environment(TransactionManager.self) private var manager
    
    @ViewBuilder
    private var sectionTitle: some View {
        Text("Giao dịch gần đây:")
            .padding(.top, AppSpacing.lg)
            .padding(.bottom, AppSpacing.xs)
            .padding(.horizontal, AppSpacing.lg)
            .font(AppTypography.headline)
            .foregroundStyle(AppColor.textPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var body: some View {
        Section {
            sectionTitle.ewalletPlainListRow()
            if transactions.isEmpty {
                EmptyTransactionsView {
                    onRefresh()
                }
                .ewalletPlainListRow()
            } else {
                ForEach(transactions) { tx in
                    TransactionRowView(transaction: tx, action: onTransactionTap)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                withAnimation {
                                    manager.delete(id: tx.id)
                                }
                            } label: {
                                Label("Xóa", systemImage: "trash")
                            }
                        }
                        .ewalletPlainListRow()
                }
                .padding(.horizontal, AppSpacing.lg)
            }
        }
    }
}

private extension View {
    /// List row mặc định có inset + separator → chỉnh để giống spacing LazyVStack + ForEach.
    func ewalletPlainListRow() -> some View {
        self
            .listRowInsets(
                EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: AppSpacing.sm,
                    trailing: 0
                )
            )
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
}

private enum TransactionListSectionPreviewData {
    static let samples: [Transaction] = [
        Transaction(
            id: "preview-1",
            amount: 450_000,
            note: "Mua sắm",
            category: .shopping,
            createdAt: Date()
        ),
        Transaction(
            id: "preview-2",
            amount: 120_000,
            note: nil,
            category: .bill,
            createdAt: Date().addingTimeInterval(-3600)
        ),
        Transaction(
            id: "preview-3",
            amount: 2_500_000,
            note: "Chuyển tiền",
            category: .transport,
            createdAt: Date().addingTimeInterval(-7200)
        ),
    ]
}

#Preview("List — có giao dịch") {
    List {
        TransactionListSection(
            transactions: TransactionListSectionPreviewData.samples,
            onRefresh: {},
            onTransactionTap: { _ in }
        )
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .listSectionSeparator(.hidden)
    .background(AppColor.bgPrimary)
    .environment(TransactionManager.previewSeeded())
    
}

#Preview("List — empty") {
    List {
        TransactionListSection(
            transactions: [],
            onRefresh: {},
            onTransactionTap: { _ in }
        )
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .listSectionSeparator(.hidden)
    .background(AppColor.bgPrimary)
    .environment(TransactionManager())
}
