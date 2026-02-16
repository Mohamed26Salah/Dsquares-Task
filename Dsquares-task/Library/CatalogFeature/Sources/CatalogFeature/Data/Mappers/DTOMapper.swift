//
//  DTOMapper.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - DTO to Domain Mapper
enum DTOMapper {
    
    static func toDomain(_ dto: TokenResponseDTO) -> Token {
        Token(
            tokenType: dto.tokenType,
            accessToken: dto.accessToken,
            expiresInMins: dto.expiresInMins,
            refreshToken: dto.refreshToken
        )
    }
    
    static func toDomain(_ dto: ItemsResponseDTO) -> ItemsResponse {
        ItemsResponse(
            totalItems: dto.totalItems,
            totalPages: dto.totalPages,
            items: dto.items.map { toDomain($0) }
        )
    }
    
    static func toDomain(_ dto: ItemDTO) -> Item {
        Item(
            code: dto.code,
            name: dto.name,
            description: dto.description,
            imageUrl: dto.imageUrl,
            rewardType: dto.rewardType,
            locked: dto.locked,
            denominations: dto.denominations.map { toDomain($0) }
        )
    }
    
    static func toDomain(_ dto: DenominationDTO) -> Denomination {
        Denomination(
            code: dto.code,
            name: dto.name,
            brand: dto.brand,
            categories: dto.categories,
            inStock: dto.inStock,
            termsAndConditions: dto.termsAndConditions,
            usageInstructions: dto.usageInstructions,
            from: dto.from,
            to: dto.to,
            description: dto.description,
            denominationType: dto.denominationType,
            value: dto.value,
            points: dto.points,
            discount: dto.discount,
            redemptionChannel: dto.redemptionChannel,
            imageUrl: dto.imageUrl,
            redemptionFactor: dto.redemptionFactor
        )
    }
    
    static func toDomain(_ dto: ItemDetailDTO) -> ItemDetail {
        ItemDetail(
            brand: dto.brand,
            locked: dto.locked,
            categories: dto.categories,
            termsAndCondition: dto.termsAndCondition,
            usageInstructions: dto.usageInstructions,
            description: dto.description,
            rewardType: dto.rewardType,
            imageUrl: dto.imageUrl,
            denominations: dto.denominations.map { toDomain($0) }
        )
    }
    
    static func toDomain(_ dto: PurchaseResponseDTO) -> Purchase {
        Purchase(
            purchaseCode: dto.purchaseCode,
            orderedAt: dto.orderedAt,
            orders: dto.orders.map { toDomain($0) }
        )
    }
    
    static func toDomain(_ dto: OrderItemDTO) -> OrderItem {
        OrderItem(
            rewardType: dto.rewardType,
            code: dto.code,
            value: dto.value,
            redemptionChannel: dto.redemptionChannel,
            name: dto.name,
            quantity: dto.quantity,
            imageUrl: dto.imageUrl,
            termsAndCondition: dto.termsAndCondition,
            usageInstructions: dto.usageInstructions,
            cardCode: dto.cardCode,
            cardPin: dto.cardPin,
            cardExpiryDate: dto.cardExpiryDate
        )
    }
}

