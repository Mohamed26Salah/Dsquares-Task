//
//  Token.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Token Entity
public struct Token: Sendable {
    public let tokenType: String
    public let accessToken: String
    public let expiresInMins: Int
    public let refreshToken: String
    
    public init(
        tokenType: String,
        accessToken: String,
        expiresInMins: Int,
        refreshToken: String
    ) {
        self.tokenType = tokenType
        self.accessToken = accessToken
        self.expiresInMins = expiresInMins
        self.refreshToken = refreshToken
    }
}

