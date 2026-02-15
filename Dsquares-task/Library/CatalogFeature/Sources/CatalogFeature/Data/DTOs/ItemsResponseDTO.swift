//
//  ItemsResponseDTO.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Items Listing DTOs
struct ItemsResponseDTO: Decodable, Sendable {
    let totalItems: Int
    let totalPages: Int
    let items: [ItemDTO]
}

struct ItemDTO: Decodable, Sendable {
    let code: String
    let name: String
    let description: String?
    let imageUrl: String?
    let rewardType: String
    let locked: Bool
    let denominations: [DenominationDTO]
}

struct DenominationDTO: Decodable, Sendable {
    let code: String
    let name: String
    let brand: String?
    let categories: [String]?
    let inStock: Bool
    let termsAndConditions: String?
    let usageInstructions: String?
    let from: Double
    let to: Double
    let description: String?
    let denominationType: String
    let value: Double?
    let points: Int?
    let discount: String?
    let redemptionChannel: String?
    let imageUrl: String?
    let redemptionFactor: Double?
    
    enum CodingKeys: String, CodingKey {
        case code, name, brand, categories, inStock, from, to, description
        case denominationType, value, points, discount, imageUrl
        case termsAndConditions, usageInstructions
        case redemptionChannel, redemptionFactor
    }
}
