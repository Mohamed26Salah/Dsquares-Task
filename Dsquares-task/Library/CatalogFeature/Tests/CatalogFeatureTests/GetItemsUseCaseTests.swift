//
//  GetItemsUseCaseTests.swift
//  CatalogFeatureTests
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Testing
import Foundation
@testable import CatalogFeature

// MARK: - Get Items Use Case Tests
struct GetItemsUseCaseTests {
    
    // MARK: - Test Success Case
    
    @Test("GetItemsUseCase should successfully retrieve items")
    func testGetItemsSuccess() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GetItemsUseCase(repository: mockRepository)
        
        let expectedItems = ItemsResponseEntity(
            totalItems: 10,
            totalPages: 2,
            items: [
                ItemEntity(
                    code: "ITEM001",
                    name: "Test Item",
                    description: "Test Description",
                    imageUrl: "https://example.com/image.jpg",
                    rewardType: "Gift Card",
                    locked: false,
                    denominations: []
                )
            ]
        )
        
        let requestBody = GetItemsRequestBody(
            page: 1,
            pageSize: 10,
            name: nil,
            categoryCode: nil,
            rewardTypes: []
        )
        
        mockRepository.getItemsResult = .success(expectedItems)
        
        // When
        let result = try await useCase.execute(request: requestBody)
        
        // Then
        #expect(mockRepository.getItemsCalled == true)
        #expect(result.totalItems == expectedItems.totalItems)
        #expect(result.totalPages == expectedItems.totalPages)
        #expect(result.items.count == expectedItems.items.count)
        #expect(result.items.first?.code == expectedItems.items.first?.code)
    }
    
    // MARK: - Test Error Case
    
    @Test("GetItemsUseCase should propagate repository error")
    func testGetItemsError() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GetItemsUseCase(repository: mockRepository)
        
        let expectedError = NSError(
            domain: "TestError",
            code: 404,
            userInfo: [NSLocalizedDescriptionKey: "Items not found"]
        )
        
        let requestBody = GetItemsRequestBody(
            page: 1,
            pageSize: 10,
            name: nil,
            categoryCode: nil,
            rewardTypes: []
        )
        
        mockRepository.getItemsResult = .failure(expectedError)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await useCase.execute(request: requestBody)
        }
        
        #expect(mockRepository.getItemsCalled == true)
    }
    
    // MARK: - Test Repository Call with Parameters
    
    @Test("GetItemsUseCase should call repository with correct request body")
    func testGetItemsCallsRepositoryWithCorrectParameters() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GetItemsUseCase(repository: mockRepository)
        
        let requestBody = GetItemsRequestBody(
            page: 2,
            pageSize: 20,
            name: "Test",
            categoryCode: "CAT001",
            rewardTypes: ["Gift Card"]
        )
        
        let expectedItems = ItemsResponseEntity(
            totalItems: 0,
            totalPages: 0,
            items: []
        )
        
        mockRepository.getItemsResult = .success(expectedItems)
        
        // When
        _ = try await useCase.execute(request: requestBody)
        
        // Then
        #expect(mockRepository.getItemsCalled == true)
        #expect(mockRepository.getItemsRequestBody?.page == requestBody.page)
        #expect(mockRepository.getItemsRequestBody?.pageSize == requestBody.pageSize)
        #expect(mockRepository.getItemsRequestBody?.name == requestBody.name)
        #expect(mockRepository.getItemsRequestBody?.categoryCode == requestBody.categoryCode)
    }
    
    // MARK: - Test Empty Items Response
    
    @Test("GetItemsUseCase should handle empty items response")
    func testGetItemsEmptyResponse() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GetItemsUseCase(repository: mockRepository)
        
        let emptyItems = ItemsResponseEntity(
            totalItems: 0,
            totalPages: 0,
            items: []
        )
        
        let requestBody = GetItemsRequestBody(
            page: 1,
            pageSize: 10,
            name: nil,
            categoryCode: nil,
            rewardTypes: []
        )
        
        mockRepository.getItemsResult = .success(emptyItems)
        
        // When
        let result = try await useCase.execute(request: requestBody)
        
        // Then
        #expect(result.items.isEmpty == true)
        #expect(result.totalItems == 0)
        #expect(result.totalPages == 0)
    }
}
