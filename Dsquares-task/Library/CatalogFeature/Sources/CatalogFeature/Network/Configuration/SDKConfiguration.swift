//
//  SDKConfiguration.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import Foundation

final class SDKConfiguration: @unchecked Sendable {
    static let shared = SDKConfiguration()
    
    private(set) var apiKey: String?
    private(set) var accessToken: String?
    private(set) var baseURL: String = "https://giftcards-preprod.dsquares.com"
    private(set) var environment: Environment = .production
    private(set) var language: String = "en" // "en" or "ar"
    
    private init() {}
    
    func configure(
        apiKey: String,
        environment: Environment = .production,
        language: String = "en"
    ) {
        self.apiKey = apiKey
        self.environment = environment
        self.baseURL = environment.baseURL
        self.language = language
    }
    
    func setAccessToken(_ token: String) {
        self.accessToken = token
    }
    
    func clearAccessToken() {
        self.accessToken = nil
    }
}

enum Environment: Sendable {
    case production
    case staging
    case development
    
    var baseURL: String {
        switch self {
        case .production:
            return "https://giftcards-preprod.dsquares.com"
        case .staging:
            return "https://giftcards-preprod.dsquares.com"
        case .development:
            return "https://giftcards-preprod.dsquares.com"
        }
    }
}
