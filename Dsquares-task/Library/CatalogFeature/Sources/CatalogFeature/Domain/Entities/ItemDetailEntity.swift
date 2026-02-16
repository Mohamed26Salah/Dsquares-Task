//
//  ItemDetailEntity.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Item Detail Entity
public struct ItemDetailEntity: Sendable {
    public let brand: String
    public let locked: Bool
    public let categories: [String]
    public let termsAndCondition: String?
    public let usageInstructions: String?
    public let description: String?
    public let rewardType: String
    public let imageUrl: String?
    public let denominations: [DenominationEntity]
    
    public init(
        brand: String,
        locked: Bool,
        categories: [String],
        termsAndCondition: String?,
        usageInstructions: String?,
        description: String?,
        rewardType: String,
        imageUrl: String?,
        denominations: [DenominationEntity]
    ) {
        self.brand = brand
        self.locked = locked
        self.categories = categories
        self.termsAndCondition = termsAndCondition
        self.usageInstructions = usageInstructions
        self.description = description
        self.rewardType = rewardType
        self.imageUrl = imageUrl
        self.denominations = denominations
    }
}

