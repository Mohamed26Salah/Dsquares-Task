//
//  CatalogViewModel.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

//
//  CatalogViewModel.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation
import Combine

@MainActor
public final class CatalogViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    let getItemsUseCase: GetItemsUseCaseProtocol
    
    // MARK: - Published State
    
    @Published var catalogItemsAdapter: CatalogItemsAdapter?
    @Published var isLoadingNextPage = false
    @Published var selectedRewardFilter = ""
    @Published var searchText: String = ""

    // MARK: - Private State
    
    /// All accumulated items from all pages loaded so far.
    private var allItems: [ItemEntity] = []
    
    /// Pagination metadata from the most recent response.
    private var totalItems: Int = 0
    private var totalPages: Int = 0
    private var currentPage: Int = 0
    
    /// The last request used, for building the next page request.
    private var lastRequest: GetItemsRequestBody?
    
    /// Combine cancellables.
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    
    var hasNextPage: Bool {
        currentPage < totalPages
    }
    
    // MARK: - Initialization
    
    public init(getItemsUseCase: GetItemsUseCaseProtocol = GetItemsUseCase()) {
        self.getItemsUseCase = getItemsUseCase
        bindSearchText()
    }
    
    // MARK: - Public Methods
    
    func onAppear() {
        getCatalogItems()
    }

    
    /// Resets and reloads from page 1 with new filters.
    func applyFilters() {
        resetPagination()
        let name = searchText.isEmpty ? nil : searchText
        let rewardTypes = (selectedRewardFilter.isEmpty ? nil : [selectedRewardFilter]) ?? []
        
        getCatalogItems(
            page: 1,
            pageSize: 20,
            name: name,
            rewardTypes: rewardTypes
        )
    }
}

// MARK: - API Calls
private extension CatalogViewModel {
    /// Loads catalog items with optional filters & pagination.
    ///
    /// - Parameters:
    ///   - page: Page number to load (defaults to 1).
    ///   - pageSize: Number of items per page.
    ///   - name: Optional name filter.
    ///   - categoryCode: Optional category code filter.
    ///   - rewardTypes: Optional reward types filter.
    ///   - isLoadingMore: Whether this is a pagination request (appends items) or fresh load (replaces items).
    func getCatalogItems(
        page: Int = 1,
        pageSize: Int = 20,
        name: String? = nil,
        categoryCode: String? = nil,
        rewardTypes: [String?] = [],
        isLoadingMore: Bool = false
    ) {
        Task {
            if isLoadingMore {
                isLoadingNextPage = true
            }
            
            do {
                let request = GetItemsRequestBody(
                    page: page,
                    pageSize: pageSize,
                    name: name,
                    categoryCode: categoryCode,
                    rewardTypes: rewardTypes
                )
                
                let response = try await getItemsUseCase.execute(request: request)
                
                // Update pagination metadata
                lastRequest = request
                totalItems = response.totalItems
                totalPages = response.totalPages
                currentPage = page
                
                // Update items
                if isLoadingMore {
                    allItems.append(contentsOf: response.items)
                } else {
                    allItems = response.items
                }
                
                // Update adapter with accumulated items
                catalogItemsAdapter = CatalogItemsAdapter(items: allItems)
                
                isLoadingNextPage = false
                
            } catch {
                isLoadingNextPage = false
                AlertManager.show(message: error.localizedDescription)
            }
        }
    }
}

// MARK: - Subscribtions -
private extension CatalogViewModel {
    /// Subscribes to search text changes and reapplies filters with debounce.
    func bindSearchText() {
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.applyFilters()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Pagination -
private extension CatalogViewModel {
    
    /// Loads the next page of items if available.
    func loadNextPage() {
        guard hasNextPage, !isLoadingNextPage else { return }
        
        guard let lastRequest else { return }
        
        let nextPage = currentPage + 1
        
        getCatalogItems(
            page: nextPage,
            pageSize: lastRequest.pageSize ?? 20,
            name: lastRequest.name,
            categoryCode: lastRequest.categoryCode,
            rewardTypes: lastRequest.rewardTypes,
            isLoadingMore: true
        )
    }
    
    /// Resets pagination state for a fresh load.
    func resetPagination() {
        allItems = []
        totalItems = 0
        totalPages = 0
        currentPage = 0
        lastRequest = nil
        catalogItemsAdapter = nil
    }
}

// MARK: - Helper Functions -
extension CatalogViewModel {
    func updateSelectedRewardFilter(_ selectedReward: String) {
        guard selectedReward != selectedRewardFilter else {
            selectedRewardFilter = ""
            return
        }
        selectedRewardFilter = selectedReward
        applyFilters()
    }
}
    

