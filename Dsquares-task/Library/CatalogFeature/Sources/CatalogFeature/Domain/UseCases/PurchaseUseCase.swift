//
//  PurchaseUseCase.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Purchase Use Case Protocol
public protocol PurchaseUseCaseProtocol: Sendable {
    func execute(
        request: DataPurchaseRequestBody
    ) async throws -> Purchase
}

// MARK: - Purchase Use Case Implementation
public struct PurchaseUseCase: PurchaseUseCaseProtocol {
    
    private let repository: DsquaresRepoProtocol
    
    public init(repository: DsquaresRepoProtocol) {
        self.repository = repository
    }
    
    public func execute(
        request: DataPurchaseRequestBody
    ) async throws -> Purchase {
        return try await repository.purchase(requestBody: request)
    }
}

