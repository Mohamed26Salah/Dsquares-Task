//
//  GetItemsUseCase.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Get Items Use Case Protocol
public protocol GetItemsUseCaseProtocol: Sendable {
    func execute(
        request: GetItemsRequestBody
    ) async throws -> ItemsResponseEntity
}

// MARK: - Get Items Use Case Implementation
public struct GetItemsUseCase: GetItemsUseCaseProtocol {
    
    private let repository: DsquaresRepoProtocol
    
    public init(repository: DsquaresRepoProtocol = DsquaresRepo()) {
        self.repository = repository
    }
    
    public func execute(
        request: GetItemsRequestBody
    ) async throws -> ItemsResponseEntity {
        return try await repository.getItems(
            requestBody: request
        )
    }
}

