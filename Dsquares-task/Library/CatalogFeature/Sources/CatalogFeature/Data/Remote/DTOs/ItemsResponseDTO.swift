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

// MARK: - Mock Data Generator
extension ItemsResponseDTO {
    static func mock(itemCount: Int = 20, pageSize: Int = 10) -> ItemsResponseDTO {
        let items = (0..<itemCount).map { ItemDTO.random(index: $0) }
        return ItemsResponseDTO(
            totalItems: itemCount,
            totalPages: (itemCount + pageSize - 1) / pageSize,
            items: items
        )
    }
    
    static var mockEmpty: ItemsResponseDTO {
        ItemsResponseDTO(totalItems: 0, totalPages: 0, items: [])
    }
}

extension ItemDTO {
    static func random(index: Int) -> ItemDTO {
        let brands = ["Noon", "Amazon", "Starbucks", "Carrefour", "IKEA", "H&M", "Zara", "Nike", "Adidas", "Apple"]
        let rewardTypes = ["GiftCards", "Discounts", "Cashback", "Vouchers"]
        let brand = brands.randomElement()!
        let rewardType = rewardTypes.randomElement()!
        
        return ItemDTO(
            code: "b-\(173615 + index)",
            name: brand,
            description: "Shop amazing deals at \(brand). Limited time offers available.",
            imageUrl: "https://picsum.photos/seed/\(brand.lowercased())\(index)/400/300",
            rewardType: rewardType,
            locked: Bool.random(),
            denominations: DenominationDTO.randomSet(brand: brand, type: rewardType)
        )
    }
}

extension DenominationDTO {
    static func randomSet(brand: String, type: String) -> [DenominationDTO] {
        let count = Int.random(in: 2...4)
        return (0..<count).map { random(index: $0, brand: brand, type: type) }
    }
    
    static func random(index: Int, brand: String, type: String) -> DenominationDTO {
        let values: [Double] = [25, 50, 100, 200, 500]
        let discounts = ["5", "10", "15", "20", "25"]
        let categories = [["Electronics"], ["Fashion"], ["Food & Beverage"], ["Grocery"], ["All Categories"]]
        let channels = ["Online", "InStore", "OnlineAndInStore"]
        
        let isDiscount = type == "Discounts"
        let value = isDiscount ? 0 : values.randomElement()!
        let discount = isDiscount ? discounts.randomElement()! : "0.00"
        
        return DenominationDTO(
            code: "i-\(236679 + index)",
            name: isDiscount ? "\(discount)%" : "\(Int(value)) {SAR}",
            brand: brand,
            categories: categories.randomElement(),
            inStock: Bool.random(),
            termsAndConditions: "<ul><li><p>Non-refundable. Valid for 12 months.</p></li></ul>",
            usageInstructions: "<ul><li><p>Present at checkout or enter code online.</p></li></ul>",
            from: isDiscount ? 0 : value,
            to: isDiscount ? 0 : value,
            description: "<p>\(isDiscount ? "Get \(discount)% off" : "Gift card worth \(Int(value)) SAR").</p>",
            denominationType: isDiscount ? "Discount" : "Value",
            value: isDiscount ? Double(discount) : value * 27,
            points: isDiscount ? Int(discount)! * 2000 : Int(value) * 540,
            discount: discount,
            redemptionChannel: channels.randomElement(),
            imageUrl: "https://picsum.photos/seed/\(brand.lowercased())\(Int(value))/300/200",
            redemptionFactor: 20
        )
    }
}
