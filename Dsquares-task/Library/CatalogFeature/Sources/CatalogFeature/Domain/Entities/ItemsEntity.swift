//
//  ItemsEntities.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Items Response Entity
public struct ItemsResponseEntity: Sendable {
    public let totalItems: Int
    public let totalPages: Int
    public let items: [ItemEntity]
    
    public init(
        totalItems: Int,
        totalPages: Int,
        items: [ItemEntity]
    ) {
        self.totalItems = totalItems
        self.totalPages = totalPages
        self.items = items
    }
}

// MARK: - Item Entity
public struct ItemEntity: Sendable {
    public let code: String
    public let name: String
    public let description: String?
    public let imageUrl: String?
    public let rewardType: String
    public let locked: Bool
    public let denominations: [DenominationEntity]
    
    public init(
        code: String,
        name: String,
        description: String?,
        imageUrl: String?,
        rewardType: String,
        locked: Bool,
        denominations: [DenominationEntity]
    ) {
        self.code = code
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.rewardType = rewardType
        self.locked = locked
        self.denominations = denominations
    }
}

// MARK: - Denomination Entity
public struct DenominationEntity: Sendable {
    public let code: String
    public let name: String
    public let brand: String?
    public let categories: [String]?
    public let inStock: Bool
    public let termsAndConditions: String?
    public let usageInstructions: String?
    public let from: Double
    public let to: Double
    public let description: String?
    public let denominationType: String
    public let value: Double?
    public let points: Int?
    public let discount: String?
    public let redemptionChannel: String?
    public let imageUrl: String?
    public let redemptionFactor: Double?
    
    public init(
        code: String,
        name: String,
        brand: String?,
        categories: [String]?,
        inStock: Bool,
        termsAndConditions: String?,
        usageInstructions: String?,
        from: Double,
        to: Double,
        description: String?,
        denominationType: String,
        value: Double?,
        points: Int?,
        discount: String?,
        redemptionChannel: String?,
        imageUrl: String?,
        redemptionFactor: Double?
    ) {
        self.code = code
        self.name = name
        self.brand = brand
        self.categories = categories
        self.inStock = inStock
        self.termsAndConditions = termsAndConditions
        self.usageInstructions = usageInstructions
        self.from = from
        self.to = to
        self.description = description
        self.denominationType = denominationType
        self.value = value
        self.points = points
        self.discount = discount
        self.redemptionChannel = redemptionChannel
        self.imageUrl = imageUrl
        self.redemptionFactor = redemptionFactor
    }
}


