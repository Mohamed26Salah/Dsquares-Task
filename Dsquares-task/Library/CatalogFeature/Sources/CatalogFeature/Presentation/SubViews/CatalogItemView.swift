//
//  CatalogItemView.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import SwiftUI

struct CatalogItemView: View {
    
    // MARK: - Properties
    let image: String
    let title: String
    let pointsDescription: String
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Metrics.verticalSpacing) {
            imageView
            infoView
        }
        .cornerRadius(Metrics.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                .inset(by: Metrics.borderInset)
                .stroke(Style.borderColor, lineWidth: Metrics.borderWidth)
        )
        .onTapGesture {
            onTap()
        }
    }
    
    // MARK: - Subviews
    
    private var imageView: some View {
        Image(systemName: "house")
            .resizable()
            .frame(width: Metrics.imageWidth, height: Metrics.imageHeight)
            .scaledToFit()
    }
    
    private var infoView: some View {
        VStack(alignment: .leading, spacing: Metrics.infoSpacing) {
            Text(title)
                .font(.system(size: Metrics.titleFontSize))
                .foregroundColor(Style.textColor)
            
            HStack(spacing: Metrics.pointsSpacing) {
                Text(pointsDescription)
                    .font(.system(size: Metrics.pointsFontSize))
                    .fontWeight(.bold)
                    .foregroundColor(Style.textColor)
                
                Text("point")
                    .font(.system(size: Metrics.pointsFontSize))
                    .foregroundColor(Style.textColor)
            }
        }
        .padding(.vertical, Metrics.infoVerticalPadding)
        .padding(.horizontal, Metrics.infoHorizontalPadding)
    }
}

// MARK: - Metrics

private enum Metrics {
    static let cornerRadius: CGFloat = 8
    static let borderWidth: CGFloat = 1.5
    static let borderInset: CGFloat = 0.75
    
    static let imageWidth: CGFloat = 163.5
    static let imageHeight: CGFloat = 100
    
    static let verticalSpacing: CGFloat = 0
    
    static let infoSpacing: CGFloat = 6
    static let infoVerticalPadding: CGFloat = 10
    static let infoHorizontalPadding: CGFloat = 14

    static let titleFontSize: CGFloat = 16
    static let pointsFontSize: CGFloat = 16
    static let pointsSpacing: CGFloat = 4
}

// MARK: - Style

private enum Style {
    static let textColor: Color = .black
    static let borderColor: Color = Color(red: 0.85, green: 0.89, blue: 0.92)
}

// MARK: - Performance Enhancement

extension CatalogItemView: @MainActor Equatable {
    public static func == (lhs: CatalogItemView, rhs: CatalogItemView) -> Bool {
        lhs.image == rhs.image &&
        lhs.title == rhs.title &&
        lhs.pointsDescription == rhs.pointsDescription
    }
}

// MARK: - Preview

#Preview {
    CatalogItemView(
        image: "",
        title: "Ikea",
        pointsDescription: "From 500"
    ) { }
}
