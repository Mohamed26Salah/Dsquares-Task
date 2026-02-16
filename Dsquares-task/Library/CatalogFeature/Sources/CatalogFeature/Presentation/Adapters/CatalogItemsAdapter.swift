//
//  CatalogItemsAdapter.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation
import SwiftUI

// MARK: - Catalog Items Adapter

/// Presentation adapter responsible for transforming domain entities
/// into UI-ready data structures.
struct CatalogItemsAdapter: Equatable {
    
    // MARK: - Nested Types
    
    struct Item: Identifiable, Sendable, Equatable  {
        let id: String
        let code: String
        let name: String
        let description: String
        let imageUrl: String?
        let rewardType: String
        let locked: Bool
        
        init(entity: ItemEntity) {
            self.id = entity.code
            self.code = entity.code
            self.name = entity.name
            self.description = entity.description ?? ""
            self.imageUrl = entity.imageUrl
            self.rewardType = entity.rewardType
            self.locked = entity.locked
        }
    }
    
    // MARK: - Properties
    let items: [Item]
    let rewardTypes: [String]
    
    // MARK: - Initializers
    /// Transforms domain entities into presentation models.
    init(items: [ItemEntity]) {
        self.items = items.map(Item.init(entity:))
        self.rewardTypes = Self.buildRewardTypes(from: items)
    }
    
    // MARK: - Private Helpers
    private static func buildRewardTypes(from items: [ItemEntity]) -> [String] {
        Array(Set(items.map(\.rewardType))).sorted()
    }
}
