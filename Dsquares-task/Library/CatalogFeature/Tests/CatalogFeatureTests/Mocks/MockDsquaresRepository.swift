//
//  MockDsquaresRepository.swift
//  CatalogFeatureTests
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation
@testable import CatalogFeature

// MARK: - Mock Repository for Testing
final class MockDsquaresRepository: DsquaresRepoProtocol, @unchecked Sendable {
    
    // MARK: - Properties
    
    var generateTokenResult: Result<TokenEntity, Error>?
    var getItemsResult: Result<ItemsResponseEntity, Error>?
    var getItemDetailsResult: Result<ItemDetailEntity, Error>?
    var purchaseResult: Result<PurchaseEntity, Error>?
    
    var generateTokenCalled = false
    var generateTokenUserIdentifier: String?
    
    var getItemsCalled = false
    var getItemsRequestBody: GetItemsRequestBody?
    
    var getItemDetailsCalled = false
    var getItemDetailsCode: String?
    
    var purchaseCalled = false
    var purchaseRequestBody: DataPurchaseRequestBody?
    
    // MARK: - DsquaresRepoProtocol Implementation
    
    func generateToken(userIdentifier: String) async throws -> TokenEntity {
        generateTokenCalled = true
        generateTokenUserIdentifier = userIdentifier
        
        if let result = generateTokenResult {
            switch result {
            case .success(let token):
                return token
            case .failure(let error):
                throw error
            }
        }
        
        throw NSError(domain: "MockRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "generateTokenResult not set"])
    }
    
    func getItems(requestBody: GetItemsRequestBody) async throws -> ItemsResponseEntity {
        getItemsCalled = true
        getItemsRequestBody = requestBody
        
        if let result = getItemsResult {
            switch result {
            case .success(let items):
                return items
            case .failure(let error):
                throw error
            }
        }
        
        throw NSError(domain: "MockRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "getItemsResult not set"])
    }
    
    func getItemDetails(code: String) async throws -> ItemDetailEntity {
        getItemDetailsCalled = true
        getItemDetailsCode = code
        
        if let result = getItemDetailsResult {
            switch result {
            case .success(let itemDetail):
                return itemDetail
            case .failure(let error):
                throw error
            }
        }
        
        throw NSError(domain: "MockRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "getItemDetailsResult not set"])
    }
    
    func purchase(requestBody: DataPurchaseRequestBody) async throws -> PurchaseEntity {
        purchaseCalled = true
        purchaseRequestBody = requestBody
        
        if let result = purchaseResult {
            switch result {
            case .success(let purchase):
                return purchase
            case .failure(let error):
                throw error
            }
        }
        
        throw NSError(domain: "MockRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "purchaseResult not set"])
    }
    
    // MARK: - Helper Methods
    
    func reset() {
        generateTokenCalled = false
        generateTokenUserIdentifier = nil
        generateTokenResult = nil
        
        getItemsCalled = false
        getItemsRequestBody = nil
        getItemsResult = nil
        
        getItemDetailsCalled = false
        getItemDetailsCode = nil
        getItemDetailsResult = nil
        
        purchaseCalled = false
        purchaseRequestBody = nil
        purchaseResult = nil
    }
}
