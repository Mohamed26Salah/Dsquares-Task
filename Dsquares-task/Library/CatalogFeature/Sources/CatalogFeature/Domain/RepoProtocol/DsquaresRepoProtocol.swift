//
//  DsquaresRepoProtocol.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//


// MARK: - Data Layer Repository Protocol
public protocol DsquaresRepoProtocol: Sendable {
    func generateToken(userIdentifier: String) async throws -> TokenEntity
    func getItems(requestBody: GetItemsRequestBody) async throws -> ItemsResponseEntity
    func getItemDetails(code: String) async throws -> ItemDetailEntity
    func purchase(requestBody: DataPurchaseRequestBody) async throws -> PurchaseEntity
}
