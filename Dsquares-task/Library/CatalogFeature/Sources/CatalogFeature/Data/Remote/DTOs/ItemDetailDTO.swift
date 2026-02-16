//
//  File.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Item Details DTOs
struct ItemDetailDTO: Decodable, Sendable {
    let brand: String
    let locked: Bool
    let categories: [String]
    let termsAndCondition: String?
    let usageInstructions: String?
    let description: String?
    let rewardType: String
    let imageUrl: String?
    let denominations: [DenominationDTO]
}
