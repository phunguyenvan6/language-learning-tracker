//
//  HomeView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct HomeView: View {
    let onOpenTransaction: (String) -> Void
    let onAddTransaction: () -> Void
    let onOpenFilter: () -> Void
    var onOpenOnboarding: (() -> Void)? = nil
    let applyFilter: TransactionFilter
    
    @Environment(TransactionManager.self) private var manager
    
    private var displayedTransaction: [Transaction] {
        var result = manager.sortByNewest()
        if let category = applyFilter.category {
            result = result.filter { $0.category == category }
        }
        if let from = applyFilter.fromDate {
            result = result.filter {
                Calendar.current.startOfDay(for: $0.createdAt) >= Calendar.current.startOfDay(for: from)
            }
        }
        if let to = applyFilter.toDate {
            result = result.filter {
                Calendar.current.startOfDay(for: $0.createdAt) <= Calendar.current.startOfDay(for: to)
            }
        }
        return result
    }
    

    var body: some View {
        List {
            if displayedTransaction.isEmpty {
                ContentUnavailableView(
                    "Chưa có giao dịch",
                    systemImage: "tray",
                    description: Text("Nhấn + để thêm")
                )
            } else if displayedTransaction.isEmpty {
                ContentUnavailableView(
                    "Không có kết quả",
                    systemImage: "magnifyingglass",
                    description: Text("Thử xoá bộ lọc")
                )
            } else {
                ForEach(displayedTransaction) { tx in
                    VStack(alignment: .leading) {
                        Button {
                            onOpenTransaction(tx.id)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(tx.displayAmount).font(.headline)
                                Text(tx.displayNote).foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                manager.delete(id: tx.id)
                            }
                        } label: {
                            Label("Xóa", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .task {
            #if DEBUG
            guard !PreviewRuntime.isRunning else { return }
            guard manager.transactions.isEmpty else { return }
            seedSampleTransactions()
            #endif
        }
        .navigationTitle("Giao dịch")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onOpenFilter()
                } label: {
                    if applyFilter.isActive {
                        Badge(count: applyFilter.totalFilter)
                    } else {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onAddTransaction()
                } label: {
                    Image(systemName: "plus")
                }
            }
            #if DEBUG
            ToolbarItem(placement: .topBarLeading) {
                Button("Onboarding") {
                    onOpenOnboarding?()
                }
                .font(.caption)
            }
            #endif

        }
    }
    
    private func seedSampleTransactions() {
            let samples: [(Double, String?, TransactionCategory, Date)] = [
                (850_000, "Đi chợ", .food, Date().addingTimeInterval(-41000)),
                (2_500_000, "Chuyển tiền", .transport,  Date().addingTimeInterval(-12000)),
                (120_000, nil, .bill, Date().addingTimeInterval(-2000)),
                (450_000, "Mua sắm", .shopping, Date().addingTimeInterval(-1000)),
            ]
            for sample in samples {
                do {
                    try manager.add(
                        amount: sample.0,
                        note: sample.1,
                        category: sample.2,
                        createdAt: sample.3
                    )
                } catch let error as LocalizedError {
                    print(error.errorDescription ?? String(describing: error))
                } catch {
                    print(error)
                }
            }
        }
}

#if DEBUG
private enum PreviewRuntime {
    static var isRunning: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
#endif

private struct HomePreviewShell: View {
    let manager: TransactionManager

    @State private var path: [AppRoute] = []
    @State private var activeSheet: HomeSheet? = nil
    @State private var activeCover: AppCover? = nil
    @State private var draftFilter = TransactionFilter.empty
    @State private var appliedFilter = TransactionFilter.empty

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(
                onOpenTransaction: { path.append(.transactionDetail(id: $0)) },
                onAddTransaction: {
                    activeSheet = .add
                },
                onOpenFilter: {
                    activeSheet = .filter
                },
                onOpenOnboarding: {
                    activeCover = .onboarding
                },
                applyFilter: appliedFilter,
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .transactionDetail(let id):
                    TransactionDetailView(transactionId: id)
                }
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .filter:
                FilterSheetView(
                    draft: $draftFilter,
                    onApply: {
                        withAnimation(.snappy) {
                            appliedFilter = draftFilter
                        }
                    },
                    onClear: {
                        withAnimation(.snappy) {
                            draftFilter = .empty
                            appliedFilter = .empty
                        }
                    }
                )
            case .add:
                NavigationStack {
                    AddTransactionView()
                }
//            case .edit(id: let id):
            }
        }
        .fullScreenCover(item: $activeCover) { cover in
            switch cover {
            case .onboarding:
                OnboardingView {
                    activeCover = nil
                }
            }
        }
        .onChange(of: activeSheet) { _, newValue in
            if newValue == .filter {
                draftFilter = appliedFilter
            }
        }
        .environment(manager)
    }
}

#Preview("Seeded — interactive") {
    HomePreviewShell(manager: .previewSeeded())
}

#Preview("Empty") {
    HomePreviewShell(manager: TransactionManager())
}

#Preview("Seeded Dark") {
    HomePreviewShell(manager: .previewSeeded())
        .preferredColorScheme(.dark)
}

#Preview("Empty Dark") {
    HomePreviewShell(manager: TransactionManager())
        .preferredColorScheme(.dark)
}
