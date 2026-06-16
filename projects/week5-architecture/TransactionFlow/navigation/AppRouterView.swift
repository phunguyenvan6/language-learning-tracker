//
//  AppRouterView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct AppRouterView: View {
    @Environment(TransactionStore.self) private var store
    @State private var path: [AppRoute] = []
    @State private var activeSheet: HomeSheet? = nil
    @State private var activeCover: AppCover? = nil

    @State private var draftFilter = TransactionFilter.empty

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(
                onOpenTransaction: { id in
                    path.append(.transactionDetail(id: id))
                },
                onAddTransaction: {
                    activeSheet = .add
                },
                onOpenFilter: {
                    activeSheet = .filter
                },
                onOpenOnboarding: {
                    activeCover = .onboarding
                }
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
                            store.applyFilter(draftFilter)
                        }
                    },
                    onClear: {
                        withAnimation(.snappy) {
                            draftFilter = .empty
                            store.clearFilter()
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
                draftFilter = store.appliedFilter
            }
        }

    }
}
