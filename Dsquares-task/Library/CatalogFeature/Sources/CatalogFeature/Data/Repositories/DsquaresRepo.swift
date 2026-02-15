//
//  File.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

protocol DsquaresRepoProtocol: Sendable {
    func generateToken(userIdentifier: String) async throws -> TokenResponseDTO
    func getItems(
        page: Int?,
        pageSize: Int?,
        name: String?,
        categoryCode: String?,
        rewardTypes: [String]?
    ) async throws -> ItemsResponseDTO
    func getItemDetails(code: String) async throws -> ItemDetailDTO
    func purchase(
        referenceCode: String,
        orderItems: [PurchaseOrderItem]
    ) async throws -> PurchaseResponseDTO
}

final class DsquaresRepop: DsquaresRepoProtocol, Sendable {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func generateToken(userIdentifier: String) async throws -> TokenResponseDTO {
        let endpoint = DsquaresEndpoint.generateToken(userIdentifier: userIdentifier)
        let response = try await networkManager.request(
            endpoint: endpoint,
            responseType: DsquaresResponse<TokenResponseDTO>.self
        )
        
        guard let result = response.result else {
            throw NetworkError.apiError(
                statusCode: response.statusCode,
                statusName: response.statusName,
                message: response.message
            )
        }
        
        // Store the access token
        SDKConfiguration.shared.setAccessToken(result.accessToken)
        
        return result
    }
    
    func getItems(
        page: Int? = 1,
        pageSize: Int? = 20,
        name: String? = nil,
        categoryCode: String? = nil,
        rewardTypes: [String]? = nil
    ) async throws -> ItemsResponseDTO {
        let endpoint = DsquaresEndpoint.getItems(
            page: page,
            pageSize: pageSize,
            name: name,
            categoryCode: categoryCode,
            rewardTypes: rewardTypes
        )
        
        let response = try await networkManager.request(
            endpoint: endpoint,
            responseType: DsquaresResponse<ItemsResponseDTO>.self
        )
        
        guard let result = response.result else {
            throw NetworkError.apiError(
                statusCode: response.statusCode,
                statusName: response.statusName,
                message: response.message
            )
        }
        
        return result
    }
    
    func getItemDetails(code: String) async throws -> ItemDetailDTO {
        let endpoint = DsquaresEndpoint.getItemDetails(code: code)
        let response = try await networkManager.request(
            endpoint: endpoint,
            responseType: DsquaresResponse<ItemDetailDTO>.self
        )
        
        guard let result = response.result else {
            throw NetworkError.apiError(
                statusCode: response.statusCode,
                statusName: response.statusName,
                message: response.message
            )
        }
        
        return result
    }
    
    func purchase(
        referenceCode: String,
        orderItems: [PurchaseOrderItem]
    ) async throws -> PurchaseResponseDTO {
        let endpoint = DsquaresEndpoint.purchase(
            referenceCode: referenceCode,
            orderItems: orderItems
        )
        
        let response = try await networkManager.request(
            endpoint: endpoint,
            responseType: DsquaresResponse<PurchaseResponseDTO>.self
        )
        
        guard let result = response.result else {
            throw NetworkError.apiError(
                statusCode: response.statusCode,
                statusName: response.statusName,
                message: response.message
            )
        }
        
        return result
    }
}
