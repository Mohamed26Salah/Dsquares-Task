//
//  TokenResponseDTO.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Authentication DTOs
struct TokenResponseDTO: Decodable, Sendable {
    let tokenType: String
    let accessToken: String
    let expiresInMins: Int
    let refreshToken: String
}
