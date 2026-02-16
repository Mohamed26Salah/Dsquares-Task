//
//  SearchBarView.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import SwiftUI

struct SearchBarView: View {
    
    // MARK: - Properties
    @Binding var text: String
    let placeholder: String
    
    
    init(text: Binding<String>, placeholder: String = "Search For Offers...") {
        self._text = text
        self.placeholder = placeholder
    }
    var body: some View {
        HStack(spacing: Metrics.horizontalSpacing) {
            imageView
            ZStack(alignment: .leading) {
                textFieldPlaceholderView
                textFieldView
            }
        }
        .padding(.horizontal, Metrics.horizontalPadding)
        .frame(height: Metrics.height)
        .background(Style.backgroundColor)
        .cornerRadius(Metrics.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                .inset(by: Metrics.borderInset)
                .stroke(Style.borderColor, lineWidth: Metrics.borderWidth)
        )
    }
    
    private var imageView: some View {
        Image(SystemImage.search)
            .resizable()
            .frame(width: SystemImage.size, height: SystemImage.size)
    }
    
    @ViewBuilder
    private var textFieldPlaceholderView: some View {
        if text.isEmpty {
            Text(placeholder)
                .foregroundColor(Style.placeholderColor)
                .font(.system(size: Metrics.fontSize))
        }
    }
    
    private var textFieldView: some View {
        TextField("", text: $text)
            .font(.system(size: Metrics.fontSize))
            .foregroundColor(Style.textColor)
    }
}

// MARK: - Metrics

private enum Metrics {
    static let cornerRadius: CGFloat = 16
    static let height: CGFloat = 44
    static let horizontalPadding: CGFloat = 16
    static let horizontalSpacing: CGFloat = 8
    static let fontSize: CGFloat = 12
    static let borderInset: CGFloat = 0.5
    static let borderWidth: CGFloat = 1
}

// MARK: - Style

private enum Style {
    static let backgroundColor: Color = .white
    static let textColor: Color = .black
    static let placeholderColor: Color = .gray
    static let iconColor: Color = .gray
    static let borderColor: Color = Color(red: 0.85, green: 0.89, blue: 0.92)
}

// MARK: - System Images

private enum SystemImage {
    static let search: ImageResource = .searchIcon
    static let size: CGFloat = 16
}


#Preview {
    SearchBarView(text: .constant(""), placeholder: "Mohamed Salah")
}
