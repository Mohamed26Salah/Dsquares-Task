//
//  Purchase.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Purchase Entity
public struct Purchase: Sendable {
    public let purchaseCode: String
    public let orderedAt: String
    public let orders: [OrderItem]
    
    public init(
        purchaseCode: String,
        orderedAt: String,
        orders: [OrderItem]
    ) {
        self.purchaseCode = purchaseCode
        self.orderedAt = orderedAt
        self.orders = orders
    }
}

// MARK: - Order Item Entity
public struct OrderItem: Sendable {
    public let rewardType: String
    public let code: String
    public let value: String
    public let redemptionChannel: String
    public let name: String
    public let quantity: Int
    public let imageUrl: String?
    public let termsAndCondition: String?
    public let usageInstructions: String?
    public let cardCode: String?
    public let cardPin: String?
    public let cardExpiryDate: String?
    
    public init(
        rewardType: String,
        code: String,
        value: String,
        redemptionChannel: String,
        name: String,
        quantity: Int,
        imageUrl: String?,
        termsAndCondition: String?,
        usageInstructions: String?,
        cardCode: String?,
        cardPin: String?,
        cardExpiryDate: String?
    ) {
        self.rewardType = rewardType
        self.code = code
        self.value = value
        self.redemptionChannel = redemptionChannel
        self.name = name
        self.quantity = quantity
        self.imageUrl = imageUrl
        self.termsAndCondition = termsAndCondition
        self.usageInstructions = usageInstructions
        self.cardCode = cardCode
        self.cardPin = cardPin
        self.cardExpiryDate = cardExpiryDate
    }
}
