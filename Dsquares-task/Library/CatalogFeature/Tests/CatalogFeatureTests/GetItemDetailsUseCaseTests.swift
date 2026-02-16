//
//  GetItemDetailsUseCaseTests.swift
//  CatalogFeatureTests
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Testing
import Foundation
@testable import CatalogFeature

// MARK: - Get Item Details Use Case Tests
struct GetItemDetailsUseCaseTests {
    
    // MARK: - Test Success Case
    
    @Test("GetItemDetailsUseCase should successfully retrieve item details")
    func testGetItemDetailsSuccess() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GetItemDetailsUseCase(repository: mockRepository)
        
        let expectedItemDetail = ItemDetailEntity(
            brand: "Test Brand",
            locked: false,
            categories: ["Category1", "Category2"],
            termsAndCondition: "Test terms",
            usageInstructions: "Test instructions",
            description: "Test description",
            rewardType: "Gift Card",
            imageUrl: "https://example.com/image.jpg",
            denominations: []
        )
        
        mockRepository.getItemDetailsResult = .success(expectedItemDetail)
        
        // When
        let result = try await useCase.execute(code: "ITEM001")
        
        // Then
        #expect(mockRepository.getItemDetailsCalled == true)
        #expect(mockRepository.getItemDetailsCode == "ITEM001")
        #expect(result.brand == expectedItemDetail.brand)
        #expect(result.locked == expectedItemDetail.locked)
        #expect(result.categories == expectedItemDetail.categories)
        #expect(result.rewardType == expectedItemDetail.rewardType)
    }
    
    // MARK: - Test Error Case
    
    @Test("GetItemDetailsUseCase should propagate repository error")
    func testGetItemDetailsError() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GetItemDetailsUseCase(repository: mockRepository)
        
        let expectedError = NSError(
            domain: "TestError",
            code: 404,
            userInfo: [NSLocalizedDescriptionKey: "Item not found"]
        )
        
        mockRepository.getItemDetailsResult = .failure(expectedError)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await useCase.execute(code: "INVALID_CODE")
        }
        
        #expect(mockRepository.getItemDetailsCalled == true)
        #expect(mockRepository.getItemDetailsCode == "INVALID_CODE")
    }
    
    // MARK: - Test Repository Call
    
    @Test("GetItemDetailsUseCase should call repository with correct code")
    func testGetItemDetailsCallsRepositoryWithCorrectCode() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GetItemDetailsUseCase(repository: mockRepository)
        
        let testCode = "ITEM123"
        let expectedItemDetail = ItemDetailEntity(
            brand: "Brand",
            locked: false,
            categories: [],
            termsAndCondition: nil,
            usageInstructions: nil,
            description: nil,
            rewardType: "Type",
            imageUrl: nil,
            denominations: []
        )
        
        mockRepository.getItemDetailsResult = .success(expectedItemDetail)
        
        // When
        _ = try await useCase.execute(code: testCode)
        
        // Then
        #expect(mockRepository.getItemDetailsCalled == true)
        #expect(mockRepository.getItemDetailsCode == testCode)
    }
    
    // MARK: - Test Locked Item
    
    @Test("GetItemDetailsUseCase should handle locked item")
    func testGetItemDetailsLockedItem() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GetItemDetailsUseCase(repository: mockRepository)
        
        let lockedItemDetail = ItemDetailEntity(
            brand: "Brand",
            locked: true,
            categories: [],
            termsAndCondition: nil,
            usageInstructions: nil,
            description: nil,
            rewardType: "Type",
            imageUrl: nil,
            denominations: []
        )
        
        mockRepository.getItemDetailsResult = .success(lockedItemDetail)
        
        // When
        let result = try await useCase.execute(code: "LOCKED001")
        
        // Then
        #expect(result.locked == true)
    }
}
