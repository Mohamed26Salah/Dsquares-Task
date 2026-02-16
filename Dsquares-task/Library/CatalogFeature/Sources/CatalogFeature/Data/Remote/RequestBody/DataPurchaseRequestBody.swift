//
//  DataPurchaseRequestBody.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

public struct DataPurchaseRequestBody: Sendable {
    let referenceCode: String
    let orderItems: [DataPurchaseOrderItem]
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

struct DataPurchaseOrderItem: Sendable {
    let itemCode: String
    let value: Double
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
