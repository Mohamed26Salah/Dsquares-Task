//
//  GetItemDetailsUseCase.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Get Item Details Use Case Protocol
public protocol GetItemDetailsUseCaseProtocol: Sendable {
    func execute(code: String) async throws -> ItemDetailEntity
}

// MARK: - Get Item Details Use Case Implementation
public struct GetItemDetailsUseCase: GetItemDetailsUseCaseProtocol {
    
    private let repository: DsquaresRepoProtocol
    
    public init(repository: DsquaresRepoProtocol) {
        self.repository = repository
    }
    
    public func execute(code: String) async throws -> ItemDetailEntity {
        return try await repository.getItemDetails(code: code)
    }
}

