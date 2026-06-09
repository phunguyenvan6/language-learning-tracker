//
//  TransactionListSection.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 2/6/26.
//

import SwiftUI

/// Section giao dịch — dùng chung cho LazyVStack và List.
///
/// - `embedInList == false` (LazyVStack): title trong `Section` **header** — giống ForEach trong ScrollView.
/// - `embedInList == true` (List): title là **row đầu** + `.ewalletPlainListRow()` — vì `header:` của List
///   render kiểu UITableView (font/padding/inset khác Text tự define).
struct TransactionListSection: View {
    /// `true` khi section nằm trong `List` (`nativeListLayout`).
    var embedInList: Bool = false

    let transactions: [Transaction]
    let onRefresh: () -> Void
    let onTransactionTap: (String) -> Void

    @ViewBuilder
    private var sectionTitle: some View {
      Text("Giao dịch gần đây:")
        .padding(.top, AppSpacing.lg)
        .padding(.bottom, AppSpacing.xs)
        .font(AppTypography.headline)
        .foregroundStyle(AppColor.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var body: some View {
      Section {
        if embedInList {
          sectionTitle.ewalletPlainListRow()
        }
        if transactions.isEmpty {
          EmptyTransactionsView { onRefresh() }
            .ewalletPlainListRow()
        } else {
          ForEach(transactions) { tx in
            TransactionRowView(transaction: tx, action: onTransactionTap)
              .ewalletPlainListRow()
          }
        }
      } header: {
        if !embedInList {
          sectionTitle 
        }
      }
    }
}

// Chỉ áp dụng cho view bên trong List — LazyVStack bỏ qua các modifier này (no-op về layout).
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

// MARK: - Previews

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

#Preview("LazyVStack — có giao dịch") {
    ScrollView {
        LazyVStack(alignment: .leading, spacing: AppSpacing.sm, pinnedViews: [.sectionHeaders]) {
            TransactionListSection(
                embedInList: false,
                transactions: TransactionListSectionPreviewData.samples,
                onRefresh: {},
                onTransactionTap: { _ in }
            )
        }
        .padding(.horizontal, AppSpacing.lg)
    }
    .background(AppColor.bgPrimary)
}

#Preview("LazyVStack — empty") {
    ScrollView {
        LazyVStack(alignment: .leading, spacing: AppSpacing.sm, pinnedViews: [.sectionHeaders]) {
            TransactionListSection(
                embedInList: false,
                transactions: [],
                onRefresh: {},
                onTransactionTap: { _ in }
            )
        }
        .padding(.horizontal, AppSpacing.lg)
    }
    .background(AppColor.bgPrimary)
}

#Preview("List — có giao dịch") {
    List {
        TransactionListSection(
            embedInList: true,
            transactions: TransactionListSectionPreviewData.samples,
            onRefresh: {},
            onTransactionTap: { _ in }
        )
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .listSectionSeparator(.hidden)
    .padding(.horizontal, AppSpacing.lg)
    .background(AppColor.bgPrimary)
}

#Preview("List — empty") {
    List {
        TransactionListSection(
            embedInList: true,
            transactions: [],
            onRefresh: {},
            onTransactionTap: { _ in }
        )
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .listSectionSeparator(.hidden)
    .padding(.horizontal, AppSpacing.lg)
    .background(AppColor.bgPrimary)
}

#Preview("LazyVStack — dark") {
    ScrollView {
        LazyVStack(alignment: .leading, spacing: AppSpacing.sm, pinnedViews: [.sectionHeaders]) {
            TransactionListSection(
                embedInList: false,
                transactions: TransactionListSectionPreviewData.samples,
                onRefresh: {},
                onTransactionTap: { _ in }
            )
        }
        .padding(.horizontal, AppSpacing.lg)
    }
    .background(AppColor.bgPrimary)
    .preferredColorScheme(.dark)
}
