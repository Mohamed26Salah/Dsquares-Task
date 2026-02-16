//
//  JSONBuildingStrategy.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

/// Wrapper around [String: Any] dictionary
typealias JSON = [String: Any & Sendable]

/// Shared behaviour for building JSON from specific type
protocol JSONBuildingStrategy {
    typealias KeyValue = (key: CodingKey, value: (any Sendable)?)
    
    var keyValuePairs: [KeyValue] { get }
    func buildJSON() -> JSON
}

extension JSONBuildingStrategy {
    func buildJSON() -> JSON {
        var result = JSON()
        keyValuePairs.forEach { key, value in
            if let value = value {
                result[key.stringValue] = value
            }
        }
        return result
    }
}

extension Encodable {
    func buildJSONSerializationString(outputFormatting: JSONEncoder.OutputFormatting = .prettyPrinted) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = outputFormatting
        
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    func buildJSONSerializationStringForMultiPart() -> String? {
        buildJSONSerializationString(outputFormatting: .withoutEscapingSlashes)?
            .replacingOccurrences(of: "\\", with: "")
    }
}
