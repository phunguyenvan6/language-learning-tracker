//
//  ContentView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

import SwiftUI

struct ContentView: View {
    var shouldSeedOnAppear: Bool = false
    
    @State private var manager = TransactionManager()
    @State private var listRevision = 0
    @State private var useNativeList = false
    
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
    ContentView()
}

#Preview("Dark") {
    ContentView().preferredColorScheme(.dark)
}

#Preview("Empty") {
    ContentView(shouldSeedOnAppear: false)
}
