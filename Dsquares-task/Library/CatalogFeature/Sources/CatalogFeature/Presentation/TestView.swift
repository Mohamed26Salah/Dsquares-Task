//
//  SwiftUIView.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import SwiftUI

public struct SwiftUIView: View {
    private let getItemsUseCase = GetItemsUseCase(
        repository: DsquaresRepo()
    )
    
    public init() {
        
    }
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                do {
                    let data = try await getItemsUseCase.execute(
                        request: GetItemsRequestBody(
                            page: 1,
                            pageSize: 20,
                            name: nil,
                            categoryCode: nil,
                            rewardTypes: [nil]
                        )
                    )
                    print("Data generated successfully: \(data.items)")
                } catch {
                    print("Error generating token: \(error)")
                }
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
