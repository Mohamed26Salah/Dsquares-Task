//
//  File.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

// MARK: - Common Response Wrapper
struct DsquaresResponse<T: Decodable & Sendable>: Decodable, Sendable {
    let result: T?
    let statusName: String
    let message: String?
    let referenceCode: String?
    let statusCode: Int
    let errors: [String: [String]]?
}
