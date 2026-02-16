//
//  CatalogView.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import SwiftUI

public struct CatalogView: View {
    @StateObject private var viewModel: CatalogViewModel
    
    public init(viewModel: CatalogViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            SearchBarView(text: $viewModel.searchText)
                .padding(.horizontal, 24)
            filterView
            catalogGridView
        }
        .navigationTitle("Catalog")
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    @ViewBuilder
    private var filterView: some View {
        if let rewardTypes = viewModel.catalogItemsAdapter?.rewardTypes {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(rewardTypes, id: \.self) { reward in
                        FilterItemView(
                            filterName: reward,
                            isSelected: viewModel.selectedRewardFilter == reward) { selectedReward in
                                viewModel.updateSelectedRewardFilter(selectedReward)
                            }
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .padding(.vertical, 28)
        }
    }
    
    @ViewBuilder
    private var catalogGridView: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ],
                spacing: 16
            ) {
                ForEach(viewModel.catalogItemsAdapter?.items ?? []) { item in
                    CatalogItemView(
                        image: item.imageUrl ?? "",
                        title: item.name,
                        pointsDescription: item.description,
                        isLocked: item.locked
                    ) {
                        //TODO: Navigation to Item Details
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}


#Preview {
    CatalogView(viewModel: .init())
}
