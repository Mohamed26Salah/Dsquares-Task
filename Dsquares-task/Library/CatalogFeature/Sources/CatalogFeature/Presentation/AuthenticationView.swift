//
//  AuthenticationView.swift
//  CatalogFeature
//
//  Created by Mohamed Salah on 16/02/2026.
//

import SwiftUI

public struct AuthenticationView: View {
    
    // MARK: - Properties
    
    @Binding var phoneNumberText: String
    @State private var navigate = false

    public init(phoneNumberText: Binding<String> = .constant("")) {
        self._phoneNumberText = phoneNumberText
    }
    
    public var body: some View {
        //Note: Using NavigationView is bad, we should use UIKit Coordinator for iOS 15, and use NavigationStack Router for iOS 16++
        NavigationView {
            VStack(alignment: .center, spacing: Metrics.rootSpacing) {
                
                VStack(alignment: .leading, spacing: Metrics.sectionSpacing) {
                    enterPhoneNumberTitleText
                    enterPhoneNumbersubTitleText
                    enterPhoneNumberTextField
                }
                
                Spacer()
                
                PrimaryButton(
                    title: "Log In",
                    backgroundColor: Style.primaryButtonColor,
                    action: {
                        AlertManager.show(
                            title: "Message From Salah 😢",
                            message: "⚠️ No Base URL in the documentation !⚠️",
                            primaryButtonColor: .red
                        )
                    }
                )
                
                PrimaryButton(
                    title: "Catalog",
                    backgroundColor: Style.secondaryButtonColor,
                    action: {
                        navigate = true
                    }
                )
                .padding(.top, Metrics.secondaryButtonTopPadding)
                
                NavigationLink(
                    destination: CatalogView(viewModel: .init()),
                    isActive: $navigate
                ) {
                    EmptyView()
                }
            }
            .padding(.horizontal, Metrics.horizontalPadding)
        }
        
    }
    
    // MARK: - Subviews
    
    private var enterPhoneNumberTitleText: some View {
        Text("Enter Phone Number")
            .font(.system(size: Metrics.titleFontSize))
            .fontWeight(.bold)
            .foregroundColor(Style.titleColor)
    }
    
    private var enterPhoneNumbersubTitleText: some View {
        Text("Please Enter Phone Number For Authentication")
            .font(.system(size: Metrics.subtitleFontSize))
            .fontWeight(.medium)
            .foregroundColor(Style.subtitleColor)
            .padding(.top, Metrics.subtitleTopPadding)
            .padding(.bottom, Metrics.subtitleBottomPadding)
    }
    
    private var enterPhoneNumberTextField: some View {
        HStack(spacing: Metrics.textFieldSpacing) {
            
            Image(.phoneIcon)
                .resizable()
                .frame(width: Metrics.iconSize, height: Metrics.iconSize)
            
            TextField("Enter Phone Number", text: $phoneNumberText)
            
            Spacer()
        }
        .padding(.vertical, Metrics.textFieldVerticalPadding)
        .padding(.horizontal, Metrics.textFieldHorizontalPadding)
        .background(Style.textFieldBackgroundColor)
        .cornerRadius(Metrics.textFieldCornerRadius)
    }
}

// MARK: - Metrics

private enum Metrics {
    
    // Root
    static let rootSpacing: CGFloat = 0
    static let sectionSpacing: CGFloat = 0
    static let horizontalPadding: CGFloat = 20
    
    // Fonts
    static let titleFontSize: CGFloat = 16
    static let subtitleFontSize: CGFloat = 14
    
    // Subtitle spacing
    static let subtitleTopPadding: CGFloat = 12
    static let subtitleBottomPadding: CGFloat = 24
    
    // Buttons
    static let secondaryButtonTopPadding: CGFloat = 22
    
    // TextField
    static let textFieldSpacing: CGFloat = 8
    static let iconSize: CGFloat = 24
    static let textFieldVerticalPadding: CGFloat = 16
    static let textFieldHorizontalPadding: CGFloat = 14
    static let textFieldCornerRadius: CGFloat = 8
}

// MARK: - Style

private enum Style {
    
    static let titleColor: Color = .black
    
    static let subtitleColor: Color = Color(
        red: 0.43,
        green: 0.43,
        blue: 0.44
    )
    
    static let primaryButtonColor: Color = Color(
        red: 0.8,
        green: 0.06,
        blue: 0.2
    )
    
    static let secondaryButtonColor: Color = Color(
        red: 0.83,
        green: 0.83,
        blue: 0.83
    )
    
    static let textFieldBackgroundColor: Color = Color(
        red: 0.96,
        green: 0.97,
        blue: 0.97
    )
}

// MARK: - Preview

#Preview {
    AuthenticationView(phoneNumberText: .constant(""))
}
