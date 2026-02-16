//
//  File.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Purchase DTOs
struct PurchaseResponseDTO: Decodable, Sendable {
    let purchaseCode: String
    let orderedAt: String
    let orders: [OrderItemDTO]
}

struct OrderItemDTO: Decodable, Sendable {
    let rewardType: String
    let code: String
    let value: String
    let redemptionChannel: String
    let name: String
    let quantity: Int
    let imageUrl: String?
    let termsAndCondition: String?
    let usageInstructions: String?
    let cardCode: String?
    let cardPin: String?
    let cardExpiryDate: String?
}
