//
//  DataPurchaseRequestBody.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

public struct DataPurchaseRequestBody: Sendable {
    public let referenceCode: String
    public let orderItems: [DataPurchaseOrderItem]
    
    public init(referenceCode: String, orderItems: [DataPurchaseOrderItem]) {
        self.referenceCode = referenceCode
        self.orderItems = orderItems
    }
}
extension DataPurchaseRequestBody: JSONBuildingStrategy {
    enum CodingKeys: String, CodingKey {
        case referenceCode
        case orderItems
    }
    
    var keyValuePairs: [KeyValue] {
        [
            (CodingKeys.referenceCode, referenceCode),
            (CodingKeys.orderItems, orderItems)
        ]
    }
}

public struct DataPurchaseOrderItem: Sendable {
    public let itemCode: String
    public let value: Double
    
    public init(itemCode: String, value: Double) {
        self.itemCode = itemCode
        self.value = value
    }
}

extension DataPurchaseOrderItem: JSONBuildingStrategy {
    enum CodingKeys: String, CodingKey {
        case itemCode
        case value
    }
    
    var keyValuePairs: [KeyValue] {
        [
            (CodingKeys.itemCode, itemCode),
            (CodingKeys.value, value)
        ]
    }
}
