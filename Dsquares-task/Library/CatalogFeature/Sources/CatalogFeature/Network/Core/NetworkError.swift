//
//  NetworkError.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 15/02/2026.
//

import Foundation

enum NetworkError: LocalizedError, Sendable {
    case invalidURL
    case noData
    case decodingError(String)
    case serverError(statusCode: Int, message: String?)
    case networkFailure(String)
    case unauthorized
    case timeout
    case noInternetConnection
    case apiError(statusCode: Int, statusName: String, message: String?)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received from server"
        case .decodingError(let error):
            return "Failed to decode response: \(error)"
        case .serverError(let statusCode, let message):
            return "Server error (\(statusCode)): \(message ?? "Unknown error")"
        case .networkFailure(let error):
            return "Network failure: \(error)"
        case .unauthorized:
            return "Unauthorized access"
        case .timeout:
            return "Request timed out"
        case .noInternetConnection:
            return "No internet connection"
        case .apiError(let statusCode, let statusName, let message):
            return "\(statusName): \(message ?? "An error occurred")"
        }
    }
}
