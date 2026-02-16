//
//  Endpoint.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 15/02/2026.
//

import Foundation
import Alamofire

public protocol Endpoint: Sendable {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

public extension Endpoint {
    var url: String {
        return baseURL + path
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
