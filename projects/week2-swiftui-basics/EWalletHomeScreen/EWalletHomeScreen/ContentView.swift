//
//  ContentView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 27/5/26.
//

import SwiftUI

struct ContentView: View {
    var shouldSeedOnAppear: Bool = true
    
    @State private var manager = TransactionManager()
    @State private var listRevision = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.md)
            {
                HeaderView(name: "Phú")
                BalanceCard(balance: manager.totalAmount())
                QuickActionsRow()
                PromotionBannerView(
                    title: "Hoàn tiền đến 5%", description: "Thanh toán hoá đơn qua VIB Wallet", ctaTitle: "Xem ngay"
                )
                LazyVStack(alignment: .leading, spacing: AppSpacing.sm, pinnedViews: [.sectionHeaders]) {
                    Section {
                        if sortedTransactions.isEmpty {
                            EmptyTransactionsView {
                                print("refresh tapped")
                            }
                        } else {
                            ForEach(sortedTransactions) { tx in
                                TransactionRowView(transaction: tx)
                            }
                        }
                    } header: {
                        Text("Giao dịch gần đây:")
                            .padding(.top, AppSpacing.lg)
                            .padding(.bottom, AppSpacing.xs)
                            .font(AppTypography.headline)
                    }
                }
                .id(listRevision)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.horizontal, AppSpacing.lg)
            .padding(.top, AppSpacing.sm)
        }
        .background(AppColor.bgPrimary.ignoresSafeArea())
        .scrollIndicators(.hidden)
        .onAppear {
            guard shouldSeedOnAppear, manager.transactions.isEmpty else { return }
            seedSampleTransactions()
            listRevision += 1
        }
    }
    
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
