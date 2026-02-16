//
//  PurchaseUseCaseTests.swift
//  CatalogFeatureTests
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Testing
import Foundation
@testable import CatalogFeature

// MARK: - Purchase Use Case Tests
struct PurchaseUseCaseTests {
    
    // MARK: - Test Success Case
    
    @Test("PurchaseUseCase should successfully complete purchase")
    func testPurchaseSuccess() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = PurchaseUseCase(repository: mockRepository)
        
        let expectedPurchase = PurchaseEntity(
            purchaseCode: "PURCHASE001",
            orderedAt: "2026-02-16T10:00:00Z",
            orders: [
                OrderItemEntity(
                    rewardType: "Gift Card",
                    code: "ORDER001",
                    value: "100.0",
                    redemptionChannel: "Online",
                    name: "Test Order",
                    quantity: 1,
                    imageUrl: nil,
                    termsAndCondition: nil,
                    usageInstructions: nil,
                    cardCode: nil,
                    cardPin: nil,
                    cardExpiryDate: nil
                )
            ]
        )
        
        let requestBody = DataPurchaseRequestBody(
            referenceCode: "REF001",
            orderItems: [
                DataPurchaseOrderItem(itemCode: "ITEM001", value: 100.0)
            ]
        )
        
        mockRepository.purchaseResult = .success(expectedPurchase)
        
        // When
        let result = try await useCase.execute(request: requestBody)
        
        // Then
        #expect(mockRepository.purchaseCalled == true)
        #expect(result.purchaseCode == expectedPurchase.purchaseCode)
        #expect(result.orderedAt == expectedPurchase.orderedAt)
        #expect(result.orders.count == expectedPurchase.orders.count)
        #expect(result.orders.first?.code == expectedPurchase.orders.first?.code)
    }
    
    // MARK: - Test Error Case
    
    @Test("PurchaseUseCase should propagate repository error")
    func testPurchaseError() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = PurchaseUseCase(repository: mockRepository)
        
        let expectedError = NSError(
            domain: "TestError",
            code: 400,
            userInfo: [NSLocalizedDescriptionKey: "Invalid purchase request"]
        )
        
        let requestBody = DataPurchaseRequestBody(
            referenceCode: "REF001",
            orderItems: [
                DataPurchaseOrderItem(itemCode: "INVALID", value: 0.0)
            ]
        )
        
        mockRepository.purchaseResult = .failure(expectedError)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await useCase.execute(request: requestBody)
        }
        
        #expect(mockRepository.purchaseCalled == true)
    }
    
    // MARK: - Test Repository Call with Parameters
    
    @Test("PurchaseUseCase should call repository with correct request body")
    func testPurchaseCallsRepositoryWithCorrectParameters() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = PurchaseUseCase(repository: mockRepository)
        
        let requestBody = DataPurchaseRequestBody(
            referenceCode: "REF123",
            orderItems: [
                DataPurchaseOrderItem(itemCode: "ITEM001", value: 50.0),
                DataPurchaseOrderItem(itemCode: "ITEM002", value: 75.0)
            ]
        )
        
        let expectedPurchase = PurchaseEntity(
            purchaseCode: "PURCHASE123",
            orderedAt: "2026-02-16T10:00:00Z",
            orders: []
        )
        
        mockRepository.purchaseResult = .success(expectedPurchase)
        
        // When
        _ = try await useCase.execute(request: requestBody)
        
        // Then
        #expect(mockRepository.purchaseCalled == true)
        #expect(mockRepository.purchaseRequestBody?.referenceCode == requestBody.referenceCode)
        #expect(mockRepository.purchaseRequestBody?.orderItems.count == requestBody.orderItems.count)
    }
    
    // MARK: - Test Multiple Orders
    
    @Test("PurchaseUseCase should handle multiple order items")
    func testPurchaseMultipleOrderItems() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = PurchaseUseCase(repository: mockRepository)
        
        let requestBody = DataPurchaseRequestBody(
            referenceCode: "REF001",
            orderItems: [
                DataPurchaseOrderItem(itemCode: "ITEM001", value: 100.0),
                DataPurchaseOrderItem(itemCode: "ITEM002", value: 200.0),
                DataPurchaseOrderItem(itemCode: "ITEM003", value: 300.0)
            ]
        )
        
        let expectedPurchase = PurchaseEntity(
            purchaseCode: "PURCHASE001",
            orderedAt: "2026-02-16T10:00:00Z",
            orders: [
                OrderItemEntity(
                    rewardType: "Type1",
                    code: "ORDER001",
                    value: "100.0",
                    redemptionChannel: "Channel1",
                    name: "Order 1",
                    quantity: 1,
                    imageUrl: nil,
                    termsAndCondition: nil,
                    usageInstructions: nil,
                    cardCode: nil,
                    cardPin: nil,
                    cardExpiryDate: nil
                ),
                OrderItemEntity(
                    rewardType: "Type2",
                    code: "ORDER002",
                    value: "200.0",
                    redemptionChannel: "Channel2",
                    name: "Order 2",
                    quantity: 1,
                    imageUrl: nil,
                    termsAndCondition: nil,
                    usageInstructions: nil,
                    cardCode: nil,
                    cardPin: nil,
                    cardExpiryDate: nil
                )
            ]
        )
        
        mockRepository.purchaseResult = .success(expectedPurchase)
        
        // When
        let result = try await useCase.execute(request: requestBody)
        
        // Then
        #expect(result.orders.count == 2)
        #expect(result.orders[0].code == "ORDER001")
        #expect(result.orders[1].code == "ORDER002")
    }
}
