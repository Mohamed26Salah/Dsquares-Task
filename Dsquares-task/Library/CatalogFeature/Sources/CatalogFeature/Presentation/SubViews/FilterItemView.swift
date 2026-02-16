//
//  FilterItemView.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import SwiftUI

struct FilterItemView: View {
    let filterName: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Text(filterName)
            .font(.system(size: Metrics.fontSize))
            .fontWeight(.medium)
            .foregroundColor(isSelected ? Style.selectedTextColor : Style.unselectedTextColor)
            .padding(.vertical, Metrics.verticalPadding)
            .padding(.horizontal, Metrics.horizontalPadding)
            .background(isSelected ? Style.selectedBackgroundColor : Style.unselectedBackgroundColor)
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
}

// MARK: - Metrics

private enum Metrics {
    static let fontSize: CGFloat = 14
    static let verticalPadding: CGFloat = 8
    static let horizontalPadding: CGFloat = 24
    static let cornerRadius: CGFloat = 8
    static let borderWidth: CGFloat = 1
    static let borderInset: CGFloat = 0.5
}

// MARK: - Style

private enum Style {
    static let selectedTextColor: Color = .white
    static let unselectedTextColor: Color = .gray
    
    static let selectedBackgroundColor: Color = .red
    static let unselectedBackgroundColor: Color = .white
    
    static let borderColor: Color = Color(
        red: 0.76,
        green: 0.82,
        blue: 0.87
    )
}

//MARK: - Performance Enhancement -

extension FilterItemView: @MainActor Equatable {
    public static func == (lhs: FilterItemView, rhs: FilterItemView) -> Bool {
        lhs.filterName == rhs.filterName &&
        lhs.isSelected == rhs.isSelected
    }
}

#Preview {
    FilterItemView(filterName: "All", isSelected: true) {}
    FilterItemView(filterName: "Electronics", isSelected: false) {}
}
