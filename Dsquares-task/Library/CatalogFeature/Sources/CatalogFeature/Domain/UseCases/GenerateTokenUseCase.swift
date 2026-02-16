//
//  GenerateTokenUseCase.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Generate Token Use Case Protocol
public protocol GenerateTokenUseCaseProtocol: Sendable {
    func execute(userIdentifier: String) async throws -> Token
}

// MARK: - Generate Token Use Case Implementation
public struct GenerateTokenUseCase: GenerateTokenUseCaseProtocol {
    
    private let repository: DsquaresRepoProtocol
    
    public init(repository: DsquaresRepoProtocol) {
        self.repository = repository
    }
    
    public func execute(userIdentifier: String) async throws -> Token {
        return try await repository.generateToken(userIdentifier: userIdentifier)
    }
}

