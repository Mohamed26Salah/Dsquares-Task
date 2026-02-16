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

extension ItemsResponseDTO {
    static var mock: ItemsResponseDTO {
        ItemsResponseDTO(
            totalItems: 10,
            totalPages: 2,
            items: [
                .mockGiftCard1,
                .mockGiftCard2,
                .mockDiscount1,
                .mockGiftCard3,
                .mockDiscount2
            ]
        )
    }
    
    static var mockEmpty: ItemsResponseDTO {
        ItemsResponseDTO(
            totalItems: 0,
            totalPages: 0,
            items: []
        )
    }
    
    static func mockWithItems(count: Int) -> ItemsResponseDTO {
        let items = (0..<count).map { index in
            ItemDTO.mockGiftCard(index: index)
        }
        return ItemsResponseDTO(
            totalItems: count,
            totalPages: (count + 9) / 10,
            items: items
        )
    }
}

extension ItemDTO {
    static var mockGiftCard1: ItemDTO {
        ItemDTO(
            code: "b-173615",
            name: "Noon",
            description: "<p>Shop everything you need at Noon - from electronics to fashion, home essentials to beauty products.</p>",
            imageUrl: "https://picsum.photos/seed/noon/400/300",
            rewardType: "GiftCards",
            locked: false,
            denominations: [
                .mockDenomination100,
                .mockDenomination200,
                .mockDenomination500
            ]
        )
    }
    
    static var mockGiftCard2: ItemDTO {
        ItemDTO(
            code: "b-173616",
            name: "Amazon",
            description: "<p>The world's largest online retailer. Shop millions of products with fast delivery.</p>",
            imageUrl: "https://picsum.photos/seed/amazon/400/300",
            rewardType: "GiftCards",
            locked: false,
            denominations: [
                .mockDenomination50,
                .mockDenomination100,
                .mockDenomination250
            ]
        )
    }
    
    static var mockGiftCard3: ItemDTO {
        ItemDTO(
            code: "b-173617",
            name: "Starbucks",
            description: "<p>Enjoy your favorite coffee, tea, and treats at Starbucks locations worldwide.</p>",
            imageUrl: "https://picsum.photos/seed/starbucks/400/300",
            rewardType: "GiftCards",
            locked: false,
            denominations: [
                .mockDenomination25,
                .mockDenomination50
            ]
        )
    }
    
    static var mockDiscount1: ItemDTO {
        ItemDTO(
            code: "b-173618",
            name: "Landmark Group",
            description: "<p>Get discounts at popular fashion and lifestyle stores including Max, Centrepoint, and more.</p>",
            imageUrl: "https://picsum.photos/seed/landmark/400/300",
            rewardType: "Discounts",
            locked: false,
            denominations: [
                .mockDiscount10Percent,
                .mockDiscount20Percent
            ]
        )
    }
    
    static var mockDiscount2: ItemDTO {
        ItemDTO(
            code: "b-173619",
            name: "Carrefour",
            description: "<p>Save on groceries, electronics, and household items at Carrefour.</p>",
            imageUrl: "https://picsum.photos/seed/carrefour/400/300",
            rewardType: "Discounts",
            locked: true,
            denominations: [
                .mockDiscount15Percent
            ]
        )
    }
    
    static var mockLocked: ItemDTO {
        ItemDTO(
            code: "b-173620",
            name: "Premium Store",
            description: "<p>Exclusive rewards for premium members only.</p>",
            imageUrl: "https://picsum.photos/seed/premium/400/300",
            rewardType: "GiftCards",
            locked: true,
            denominations: [.mockDenomination100]
        )
    }
    
    static func mockGiftCard(index: Int) -> ItemDTO {
        ItemDTO(
            code: "b-\(173615 + index)",
            name: "Brand \(index + 1)",
            description: "<p>Description for brand \(index + 1). Discover amazing deals and offers on a wide variety of products.</p>",
            imageUrl: "https://picsum.photos/seed/brand\(index)/400/300",
            rewardType: index % 3 == 0 ? "Discounts" : "GiftCards",
            locked: index % 5 == 0,
            denominations: [.mockDenomination100]
        )
    }
}

extension DenominationDTO {
    static var mockDenomination25: DenominationDTO {
        DenominationDTO(
            code: "i-236679",
            name: "25 {SAR}",
            brand: "Starbucks",
            categories: ["Food & Beverage"],
            inStock: true,
            termsAndConditions: """
            <ul>
                <li><p>The gift card is non-refundable and cannot be exchanged for cash.</p></li>
                <li><p>Lost, stolen, or damaged cards will not be replaced.</p></li>
                <li><p>The card is valid for use only at participating locations.</p></li>
                <li><p>The card must be used before the expiry date.</p></li>
            </ul>
            """,
            usageInstructions: """
            <ul>
                <li><p>Present the gift card at checkout.</p></li>
                <li><p>The card value will be deducted from your purchase.</p></li>
                <li><p>You can check your balance online or at any store.</p></li>
            </ul>
            """,
            from: 25,
            to: 25,
            description: "<p>Perfect for your daily coffee fix. Valid at all Starbucks locations.</p>",
            denominationType: "Value",
            value: 675,
            points: 13500,
            discount: "0.00",
            redemptionChannel: "OnlineAndInStore",
            imageUrl: "https://picsum.photos/seed/starbucks25/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockDenomination50: DenominationDTO {
        DenominationDTO(
            code: "i-236680",
            name: "50 {SAR}",
            brand: "Amazon",
            categories: ["Electronics", "Books", "Fashion"],
            inStock: true,
            termsAndConditions: """
            <ul>
                <li><p>The gift card is non-refundable and cannot be exchanged for cash.</p></li>
                <li><p>Lost, stolen, or damaged cards will not be replaced.</p></li>
                <li><p>Valid for online purchases only.</p></li>
            </ul>
            """,
            usageInstructions: """
            <ul>
                <li><p>Add items to your cart on Amazon.com</p></li>
                <li><p>At checkout, enter your gift card code.</p></li>
                <li><p>The amount will be applied to your order.</p></li>
            </ul>
            """,
            from: 50,
            to: 50,
            description: "<p>Shop millions of products on Amazon with this gift card.</p>",
            denominationType: "Value",
            value: 1350,
            points: 27000,
            discount: "0.00",
            redemptionChannel: "Online",
            imageUrl: "https://picsum.photos/seed/amazon50/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockDenomination100: DenominationDTO {
        DenominationDTO(
            code: "i-236679",
            name: "100 {SAR}",
            brand: "Noon",
            categories: ["Electronics"],
            inStock: true,
            termsAndConditions: """
            <ul>
                <li><p>The gift card is non-refundable and cannot be exchanged for cash.</p></li>
                <li><p>Lost, stolen, or damaged cards will not be replaced.</p></li>
                <li><p>The card is valid for use only at participating locations or platforms.</p></li>
                <li><p>The card must be used before the expiry date, if applicable.</p></li>
                <li><p>No fees apply for card activation or usage.</p></li>
                <li><p>The card cannot be reloaded or resold.</p></li>
            </ul>
            """,
            usageInstructions: """
            <ul>
                <li><p>Receive the gift card via email, SMS, app, or printed copy.</p></li>
                <li><p>Review the redemption instructions included with the card.</p></li>
                <li><p>Go to the specified website, app, or physical store.</p></li>
                <li><p>If online, add the desired items to your shopping cart.</p></li>
                <li><p>Proceed to the checkout or payment page.</p></li>
                <li><p>Enter the gift card code in the designated field.</p></li>
                <li><p>Confirm the redemption and apply the value.</p></li>
                <li><p>Pay any remaining balance if the gift card doesn't cover the full amount.</p></li>
                <li><p>Receive confirmation of the successful transaction.</p></li>
            </ul>
            """,
            from: 100,
            to: 100,
            description: "<p>Give the Gift of Choice. Redeem this card for a wide range of products and services. It's easy to use, with no hidden fees—making it the perfect gift for any occasion.</p>",
            denominationType: "Value",
            value: 2700,
            points: 54000,
            discount: "0.00",
            redemptionChannel: "OnlineAndInStore",
            imageUrl: "https://picsum.photos/seed/noon100/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockDenomination200: DenominationDTO {
        DenominationDTO(
            code: "i-2107116350271",
            name: "200 {SAR}",
            brand: "Noon",
            categories: ["Electronics"],
            inStock: true,
            termsAndConditions: """
            <ul>
                <li><p>The gift card is non-refundable and cannot be exchanged for cash.</p></li>
                <li><p>Valid for 12 months from date of purchase.</p></li>
            </ul>
            """,
            usageInstructions: """
            <ul>
                <li><p>Use at checkout on Noon app or website.</p></li>
                <li><p>Enter the card code when prompted.</p></li>
            </ul>
            """,
            from: 200,
            to: 200,
            description: "<p>Higher value gift card for bigger purchases.</p>",
            denominationType: "Value",
            value: 5400,
            points: 108000,
            discount: "0.00",
            redemptionChannel: "OnlineAndInStore",
            imageUrl: "https://picsum.photos/seed/noon200/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockDenomination250: DenominationDTO {
        DenominationDTO(
            code: "i-236682",
            name: "250 {SAR}",
            brand: "Amazon",
            categories: ["Electronics", "Books"],
            inStock: false,
            termsAndConditions: "<ul><li><p>Standard terms apply.</p></li></ul>",
            usageInstructions: "<ul><li><p>Apply at checkout.</p></li></ul>",
            from: 250,
            to: 250,
            description: "<p>Premium value card for larger purchases.</p>",
            denominationType: "Value",
            value: 6750,
            points: 135000,
            discount: "0.00",
            redemptionChannel: "Online",
            imageUrl: "https://picsum.photos/seed/amazon250/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockDenomination500: DenominationDTO {
        DenominationDTO(
            code: "i-236683",
            name: "500 {SAR}",
            brand: "Noon",
            categories: ["Electronics", "Fashion"],
            inStock: true,
            termsAndConditions: "<ul><li><p>Premium card terms.</p></li></ul>",
            usageInstructions: "<ul><li><p>Use for premium purchases.</p></li></ul>",
            from: 500,
            to: 500,
            description: "<p>Maximum value gift card.</p>",
            denominationType: "Value",
            value: 13500,
            points: 270000,
            discount: "0.00",
            redemptionChannel: "OnlineAndInStore",
            imageUrl: "https://picsum.photos/seed/noon500/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockDiscount10Percent: DenominationDTO {
        DenominationDTO(
            code: "d-001",
            name: "10%",
            brand: "Landmark Group",
            categories: ["Fashion", "Lifestyle"],
            inStock: true,
            termsAndConditions: """
            <p>- Offers cannot be combined with other promotions or discounts.
            - Redeemable at participating stores
            - Valid for one-time use only.
            - Minimum purchase may be required.</p>
            """,
            usageInstructions: """
            <p>Present the voucher at checkout. 
            For online redemptions, enter the voucher code during checkout.</p>
            """,
            from: 0,
            to: 0,
            description: "<p>Get 10% off your purchase at Landmark Group stores.</p>",
            denominationType: "Discount",
            value: 100,
            points: 2000,
            discount: "10.00",
            redemptionChannel: "OnlineAndInStore",
            imageUrl: "https://picsum.photos/seed/landmark10/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockDiscount15Percent: DenominationDTO {
        DenominationDTO(
            code: "d-002",
            name: "15%",
            brand: "Carrefour",
            categories: ["Grocery", "Electronics"],
            inStock: true,
            termsAndConditions: "<p>Valid on purchases above 200 SAR. Cannot be combined with other offers.</p>",
            usageInstructions: "<p>Show voucher code at checkout or apply online.</p>",
            from: 0,
            to: 0,
            description: "<p>Save 15% on your Carrefour shopping.</p>",
            denominationType: "Discount",
            value: 150,
            points: 3000,
            discount: "15.00",
            redemptionChannel: "OnlineAndInStore",
            imageUrl: "https://picsum.photos/seed/carrefour15/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockDiscount20Percent: DenominationDTO {
        DenominationDTO(
            code: "d-003",
            name: "20%",
            brand: "Landmark Group",
            categories: ["Fashion", "Streaming", "Super Market"],
            inStock: true,
            termsAndConditions: """
            <p>- Offers cannot be combined with other promotions or discounts.
            - Redeemable at participating stores
            - Value Vouchers are non-refundable and cannot be exchanged for cash.
            - Valid for one-time use only.
            - Expired vouchers will not be accepted.</p>
            """,
            usageInstructions: """
            <p>Purchase the voucher of your choice using your points. 
            For in-store redemptions, present the voucher at checkout. 
            For online redemptions, enter the voucher code in the designated field on the merchant's app or website during checkout. 
            Enjoy your discount or offer!</p>
            """,
            from: 0,
            to: 0,
            description: "<p>Enjoy 20% discount at Landmark Group stores.</p>",
            denominationType: "Discount",
            value: 200,
            points: 4000,
            discount: "20.00",
            redemptionChannel: "Online",
            imageUrl: "https://picsum.photos/seed/landmark20/300/200",
            redemptionFactor: 20
        )
    }
    
    static var mockRangeDenomination: DenominationDTO {
        DenominationDTO(
            code: "r-001",
            name: "Custom Amount",
            brand: "Flexible Store",
            categories: ["All Categories"],
            inStock: true,
            termsAndConditions: "<ul><li><p>Choose any amount within range.</p></li></ul>",
            usageInstructions: "<ul><li><p>Select your desired amount at checkout.</p></li></ul>",
            from: 50,
            to: 500,
            description: "<p>Choose any amount between 50 and 500 SAR.</p>",
            denominationType: "Range",
            value: nil,
            points: nil,
            discount: "0.00",
            redemptionChannel: "OnlineAndInStore",
            imageUrl: "https://picsum.photos/seed/flexible/300/200",
            redemptionFactor: 20
        )
    }
}

// MARK: - Array Extensions
extension Array where Element == ItemDTO {
    static var mockGiftCards: [ItemDTO] {
        [.mockGiftCard1, .mockGiftCard2, .mockGiftCard3]
    }
    
    static var mockDiscounts: [ItemDTO] {
        [.mockDiscount1, .mockDiscount2]
    }
    
    static var mockMixed: [ItemDTO] {
        [.mockGiftCard1, .mockDiscount1, .mockGiftCard2, .mockDiscount2, .mockGiftCard3]
    }
    
    static var mockLocked: [ItemDTO] {
        [.mockLocked, .mockDiscount2]
    }
}
