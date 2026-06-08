//
//  ContentView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

import SwiftUI

// MARK: - List vs LazyVStack (trong project này)
//
// | | ScrollView + LazyVStack | List (nativeListLayout) |
// |---|---|---|
// | RN tương đương | ScrollView + map children | FlatList / SectionList |
// | Scroll container | ScrollView (một) | List (một) — không lồng List trong ScrollView |
// | Spacing giữa row | LazyVStack(spacing: AppSpacing.sm) | listRowInsets bottom + .ewalletPlainListRow() |
// | Header section | Section { } header: { Text } — SwiftUI layout tự do | embedInList: header = row đầu (tránh UIKit section header) |
// | Padding ngang | .padding(.horizontal) trên VStack | .padding trên List + listRowInsets leading/trailing = 0 |
// | Separator | Không có (trừ khi tự vẽ) | Mặc định có → .listRowSeparator(.hidden) |
// | Nền row | bgPrimary từ ScrollView | .listRowBackground(.clear) + scrollContentBackground(.hidden) |
// | Lazy load | LazyVStack chỉ render row trong viewport | List cũng lazy; UITableView-style recycling |
// | Khi nào dùng | Home + vài section, UI custom (banner, card) | Swipe actions, edit mode, refreshable, navigation link chuẩn iOS |
//
// Toggle: useNativeList = false → scrollLayout | true → nativeListLayout

struct ContentView: View {
    var shouldSeedOnAppear: Bool = false
    var useNativeList: Bool = false
    
    @State private var manager = TransactionManager()
    @State private var listRevision = 0
    
    var body: some View {
        Group {
            if useNativeList {
                nativeListLayout
            } else {
                scrollLayout
            }
        }
        .background(AppColor.bgPrimary.ignoresSafeArea())
        .onAppear {
            guard shouldSeedOnAppear, manager.transactions.isEmpty else { return }
            seedSampleTransactions()
            listRevision += 1
        }
    }
    
    // MARK: - Layouts

    /// ScrollView + LazyVStack: layout giống design tự define (header Text, ForEach row không inset UITableView).
    private var scrollLayout: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                homeTopContent
                LazyVStack(alignment: .leading, spacing: AppSpacing.sm, pinnedViews: [.sectionHeaders]) {
                    TransactionListSection(
                        embedInList: useNativeList,
                        transactions: sortedTransactions
                    ) {
                        onRefresh()
                    }
                }
                .id(listRevision)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.horizontal, AppSpacing.lg)
            .padding(.top, AppSpacing.sm)
        }
        .scrollIndicators(.hidden)
    }
    
    /// List là root scroll: cần .ewalletPlainListRow() + embedInList để section/header/row giống scrollLayout.
    private var nativeListLayout: some View {
        List {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                homeTopContent
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.horizontal, AppSpacing.lg)
            .padding(.top, AppSpacing.sm)
            .padding(.bottom, AppSpacing.lg)
            
            TransactionListSection(
                embedInList: useNativeList,
                transactions: sortedTransactions
            ) {
                onRefresh()
            }
            .id(listRevision)
            .padding(.horizontal, AppSpacing.lg)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .listSectionSeparator(.hidden)
    }
    
    private var homeTopContent: some View {
        Group {
            HeaderView(name: "Phú")
            BalanceCard(balance: manager.totalAmount())
            QuickActionsRow()
            PromotionBannerView(
                title: "Hoàn tiền đến 5%",
                description: "Thanh toán hoá đơn qua VIB Wallet",
                ctaTitle: "Xem ngay"
            )
        }
    }
    
    // MARK: - Data
    
    private func seedSampleTransactions() {
        let samples: [(Double, String?, TransactionCategory)] = [
            (850_000, "Đi chợ", .food),
            (2_500_000, "Chuyển tiền", .transport),
            (120_000, nil, .bill),
            (450_000, "Mua sắm", .shopping),
        ]
        for sample in samples {
            do {
                try manager.add(
                    amount: sample.0,
                    note: sample.1,
                    category: sample.2
                )
            } catch let error as LocalizedError {
                print(error.errorDescription ?? String(describing: error))
            } catch {
                print(error)
            }
        }
    }
    
    private var sortedTransactions: [Transaction] {
        manager.sortByNewest()
    }
    
    private func onRefresh() {
        guard manager.transactions.isEmpty
        else { return }
        seedSampleTransactions()
        listRevision += 1
    }
}

#Preview("Có giao dịch") {
    ContentView(shouldSeedOnAppear: true)
}

#Preview("Dark") {
    ContentView().preferredColorScheme(.dark)
}

#Preview("Empty") {
    ContentView(shouldSeedOnAppear: false)
}

#Preview("Native List") {
    ContentView(shouldSeedOnAppear: true, useNativeList: true)
}
