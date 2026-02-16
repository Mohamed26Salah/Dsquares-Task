//
//  CatalogItemView.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct CatalogItemView: View {
    
    // MARK: - Properties
    let image: String
    let title: String
    let pointsDescription: String
    let isLocked: Bool
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
        .overlay(
            lockOverlay
        )
        .onTapGesture {
            guard !isLocked else { return }
            onTap()
        }
    }
    
    // MARK: - Subviews
    
    private var imageView: some View {
        WebImage(
            url: URL(string: image),
        )
        .resizable()
        .indicator(.activity)
        .scaledToFill()
        .frame(width: Metrics.imageWidth, height: Metrics.imageHeight)
        .clipped()
    }
    
    private var infoView: some View {
        VStack(alignment: .leading, spacing: Metrics.infoSpacing) {
            Text(title)
                .font(.system(size: Metrics.titleFontSize))
                .foregroundColor(Style.textColor)
            
            Text(pointsDescription)
                .font(.system(size: Metrics.pointsFontSize))
                .fontWeight(.bold)
                .foregroundColor(Style.textColor)
                .lineLimit(1)
        }
        .padding(.vertical, Metrics.infoVerticalPadding)
        .padding(.horizontal, Metrics.infoHorizontalPadding)
    }
    
    @ViewBuilder
    private var lockOverlay: some View {
        if isLocked {
            ZStack {
                // Semi-transparent background
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(Style.lockOverlayBackground)
                
                Image(Style.lockIconImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Metrics.lockIconSize, height: Metrics.lockIconSize)
                    .foregroundColor(Style.lockIconColor)
            }
        }
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
    
    static let lockIconSize: CGFloat = 40
}

// MARK: - Style

private enum Style {
    static let textColor: Color = .black
    static let borderColor: Color = Color(red: 0.85, green: 0.89, blue: 0.92)
    
    // Lock overlay styling
    static let lockOverlayBackground: Color = .black.opacity(0.5)
    static let lockIconColor: Color = .white
    static let lockIconImage: ImageResource = .lockIcon
}

// MARK: - Performance Enhancement

extension CatalogItemView: @MainActor Equatable {
    public static func == (lhs: CatalogItemView, rhs: CatalogItemView) -> Bool {
        lhs.image == rhs.image &&
        lhs.title == rhs.title &&
        lhs.pointsDescription == rhs.pointsDescription &&
        lhs.isLocked == rhs.isLocked
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        CatalogItemView(
            image: "",
            title: "Ikea",
            pointsDescription: "From 500",
            isLocked: false
        ) { }
        
        CatalogItemView(
            image: "",
            title: "Ikea",
            pointsDescription: "From 500",
            isLocked: true
        ) { }
    }
    .padding()
}

//TODO: offerView + unavaiableCatalogue
