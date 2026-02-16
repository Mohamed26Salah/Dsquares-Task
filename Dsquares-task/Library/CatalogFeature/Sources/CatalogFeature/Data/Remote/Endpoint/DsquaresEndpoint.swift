//
//  File.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation
import Alamofire

enum DsquaresEndpoint: Endpoint {
    case generateToken(userIdentifier: String)
    case getItems(requestBody: GetItemsRequestBody)
    case getItemDetails(code: String)
    case purchase(requestBody: DataPurchaseRequestBody)
    
    var baseURL: String {
        return SDKConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .generateToken:
            return "/api/DynamicApp/v1/Integration/Token"
        case .getItems:
            return "/api/DynamicApp/v1/Integration/Items"
        case .getItemDetails:
            return "/api/DynamicApp/v1/Integration/ItemDetails"
        case .purchase:
            return "/api/DynamicApp/v1/Integration/Purchase"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .generateToken, .getItemDetails, .purchase:
            return .post
        case .getItems:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Accept-Language": SDKConfiguration.shared.language
        ]
        
        switch self {
        case .generateToken:
            // For token generation, use x-api-key
            if let apiKey = SDKConfiguration.shared.apiKey {
                headers.add(name: "x-api-key", value: apiKey)
            }
        case .getItems, .getItemDetails, .purchase:
            // For all other endpoints, use Bearer token
            if let accessToken = SDKConfiguration.shared.accessToken {
                headers.add(name: "Authorization", value: "Bearer \(accessToken)")
            }
        }
        
        return headers
    }
    
    var parameters: Parameters? {
        switch self {
        case .generateToken(let userIdentifier):
            return ["UserIdentifier": userIdentifier]
        case .getItems(let requestBody):
            return requestBody.buildJSON()
        case .getItemDetails(let code):
            return ["data": ["code": code]]
        case .purchase(let requestBody):
            return requestBody.buildJSON()
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}

// Helper struct for purchase order items
struct PurchaseOrderData: Sendable {
    let referenceCode: String
    let orderItems: [DataPurchaseOrderItem]
}

