//
//  GetItemsRequestBody.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

public struct GetItemsRequestBody: Sendable {
    let page: Int?
    let pageSize: Int?
    let name: String?
    let categoryCode: String?
    let rewardTypes: [String?]

}

extension GetItemsRequestBody: JSONBuildingStrategy {
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case name
        case categoryCode
        case rewardTypes
    }
    
    var keyValuePairs: [KeyValue] {
        [
            (CodingKeys.page, page),
            (CodingKeys.pageSize, pageSize),
            (CodingKeys.name, name),
            (CodingKeys.categoryCode, categoryCode),
            (CodingKeys.rewardTypes, rewardTypes)
        ]
    }
}
