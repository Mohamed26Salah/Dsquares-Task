//
//  File.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Data Layer Repository Implementation
public final class DsquaresRepo: DsquaresRepoProtocol, Sendable {
    
    private let networkManager: NetworkManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    /// Generates a backend access token and stores it inside `SDKConfiguration`.
    ///
    /// - Parameter userIdentifier: A unique identifier representing the user.
    /// - Returns: A `Token` domain model.
    /// - Throws: `NetworkError`
    public func generateToken(userIdentifier: String) async throws -> TokenEntity {
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
        
        return DTOMapper.toDomain(result)
    }
    
    /// Retrieves catalog items from the backend.
    ///
    /// - Parameter requestBody: Request payload containing filters, search, and pagination parameters.
    /// - Returns: An `ItemsResponse` domain model.
    /// - Throws: `NetworkError` if the network request fails or backend validation fails.
    public func getItems(
        requestBody: GetItemsRequestBody
    ) async throws -> ItemsResponseEntity {
//        let endpoint = DsquaresEndpoint.getItems(
//           requestBody: requestBody
//        )
//        
//        let response = try await networkManager.request(
//            endpoint: endpoint,
//            responseType: DsquaresResponse<ItemsResponseDTO>.self
//        )
//        
//        guard let result = response.result else {
//            throw NetworkError.apiError(
//                statusCode: response.statusCode,
//                statusName: response.statusName,
//                message: response.message
//            )
//        }
//        return DTOMapper.toDomain(result)
        return DTOMapper.toDomain(ItemsResponseDTO.mock())
    }
    
    /// Fetches detailed information for a specific catalog item.
    ///
    /// - Parameter code: Unique item code.
    /// - Returns: An `ItemDetail` domain model.
    /// - Throws: `NetworkError` if the request fails or no valid result is returned.
    public func getItemDetails(code: String) async throws -> ItemDetailEntity {
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
        
        return DTOMapper.toDomain(result)
    }
    
    /// Performs a purchase transaction through the backend.
    ///
    /// - Parameter requestBody: Purchase request payload including item and payment details.
    /// - Returns: A `Purchase` domain model representing the successful transaction.
    /// - Throws: `NetworkError`
    public func purchase(
        requestBody: DataPurchaseRequestBody
    ) async throws -> PurchaseEntity {
        let endpoint = DsquaresEndpoint.purchase(
           requestBody: requestBody
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
        
        return DTOMapper.toDomain(result)
    }
}
