//
//  GetItemsRequestBody.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

public struct GetItemsRequestBody: Sendable {
    public let page: Int?
    public let pageSize: Int?
    public let name: String?
    public let categoryCode: String?
    public let rewardTypes: [String?]
    
    public init(
        page: Int? = nil,
        pageSize: Int? = nil,
        name: String? = nil,
        categoryCode: String? = nil,
        rewardTypes: [String?] = []
    ) {
        self.page = page
        self.pageSize = pageSize
        self.name = name
        self.categoryCode = categoryCode
        self.rewardTypes = rewardTypes
    }
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
