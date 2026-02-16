//
//  GenerateTokenUseCaseTests.swift
//  CatalogFeatureTests
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Testing
import Foundation
@testable import CatalogFeature

// MARK: - Generate Token Use Case Tests
struct GenerateTokenUseCaseTests {
    
    // MARK: - Test Success Case
    
    @Test("GenerateTokenUseCase should successfully generate token")
    func testGenerateTokenSuccess() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GenerateTokenUseCase(repository: mockRepository)
        
        let expectedToken = TokenEntity(
            tokenType: "Bearer",
            accessToken: "test-access-token",
            expiresInMins: 3600,
            refreshToken: "test-refresh-token"
        )
        
        mockRepository.generateTokenResult = .success(expectedToken)
        
        // When
        let result = try await useCase.execute(userIdentifier: "test-user-123")
        
        // Then
        #expect(mockRepository.generateTokenCalled == true)
        #expect(mockRepository.generateTokenUserIdentifier == "test-user-123")
        #expect(result.tokenType == expectedToken.tokenType)
        #expect(result.accessToken == expectedToken.accessToken)
        #expect(result.expiresInMins == expectedToken.expiresInMins)
        #expect(result.refreshToken == expectedToken.refreshToken)
    }
    
    // MARK: - Test Error Case
    
    @Test("GenerateTokenUseCase should propagate repository error")
    func testGenerateTokenError() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GenerateTokenUseCase(repository: mockRepository)
        
        let expectedError = NSError(
            domain: "TestError",
            code: 500,
            userInfo: [NSLocalizedDescriptionKey: "Network error"]
        )
        
        mockRepository.generateTokenResult = .failure(expectedError)
        
        // When/Then
        await #expect(throws: NSError.self) {
            try await useCase.execute(userIdentifier: "test-user-123")
        }
        
        #expect(mockRepository.generateTokenCalled == true)
        #expect(mockRepository.generateTokenUserIdentifier == "test-user-123")
    }
    
    // MARK: - Test Repository Call
    
    @Test("GenerateTokenUseCase should call repository with correct parameters")
    func testGenerateTokenCallsRepository() async throws {
        // Given
        let mockRepository = MockDsquaresRepository()
        let useCase = GenerateTokenUseCase(repository: mockRepository)
        
        let testUserIdentifier = "user-identifier-456"
        let expectedToken = TokenEntity(
            tokenType: "Bearer",
            accessToken: "token",
            expiresInMins: 60,
            refreshToken: "refresh"
        )
        
        mockRepository.generateTokenResult = .success(expectedToken)
        
        // When
        _ = try await useCase.execute(userIdentifier: testUserIdentifier)
        
        // Then
        #expect(mockRepository.generateTokenCalled == true)
        #expect(mockRepository.generateTokenUserIdentifier == testUserIdentifier)
    }
}
