//
//  TransactionListSection.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 2/6/26.
//

import SwiftUI

/// Section giao dịch — embed trong `LazyVStack` (ScrollView) hoặc `List` (root), không tự bọc `List`.
struct TransactionListSection: View {
    var embedInList: Bool = false  // true khi gọi từ nativeListLayout

    let transactions: [Transaction]
    let onRefresh: () -> Void

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
            TransactionRowView(transaction: tx)
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

private extension View {
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
