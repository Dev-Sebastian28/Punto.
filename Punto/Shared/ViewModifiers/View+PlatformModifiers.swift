import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension View {
    @ViewBuilder
    func emailKeyboardIfAvailable() -> some View {
        #if canImport(UIKit)
        self.keyboardType(.emailAddress)
        #else
        self
        #endif
    }

    @ViewBuilder
    func decimalKeyboardIfAvailable() -> some View {
        #if canImport(UIKit)
        self.keyboardType(.decimalPad)
        #else
        self
        #endif
    }

    @ViewBuilder
    func numberKeyboardIfAvailable() -> some View {
        #if canImport(UIKit)
        self.keyboardType(.numberPad)
        #else
        self
        #endif
    }

    @ViewBuilder
    func sentencesAutocapitalizationIfAvailable() -> some View {
        #if canImport(UIKit)
        self.textInputAutocapitalization(.sentences)
        #else
        self
        #endif
    }

    @ViewBuilder
    func characterAutocapitalizationIfAvailable() -> some View {
        #if canImport(UIKit)
        self.textInputAutocapitalization(.characters)
        #else
        self
        #endif
    }
}

extension Color {
    static let brandBlue = Color(red: 0.11, green: 0.33, blue: 0.64)
    static let brandBlueDark = Color(red: 0.07, green: 0.22, blue: 0.43)
    static let brandGreen = Color(red: 0.10, green: 0.63, blue: 0.43)
    static let brandGreenDark = Color(red: 0.07, green: 0.47, blue: 0.33)
    static let brandAmber = Color(red: 0.95, green: 0.67, blue: 0.19)
    static let surfacePrimary = Color(red: 0.98, green: 0.99, blue: 1.00)
    static let surfaceSecondary = Color(red: 0.93, green: 0.96, blue: 0.99)
    static let cardStroke = Color.black.opacity(0.08)
    static let textMuted = Color.black.opacity(0.6)

    static var platformGroupedBackground: Color {
        #if canImport(UIKit)
        Color(uiColor: .systemGroupedBackground)
        #elseif canImport(AppKit)
        Color(nsColor: .underPageBackgroundColor)
        #else
        Color.gray.opacity(0.12)
        #endif
    }

    static var platformSystemBackground: Color {
        #if canImport(UIKit)
        Color(uiColor: .systemBackground)
        #elseif canImport(AppKit)
        Color(nsColor: .windowBackgroundColor)
        #else
        Color.white
        #endif
    }

    static var platformSecondaryBackground: Color {
        #if canImport(UIKit)
        Color(uiColor: .secondarySystemBackground)
        #elseif canImport(AppKit)
        Color(nsColor: .controlBackgroundColor)
        #else
        Color.gray.opacity(0.08)
        #endif
    }

    static var platformGray6: Color {
        #if canImport(UIKit)
        Color(uiColor: .systemGray6)
        #elseif canImport(AppKit)
        Color(nsColor: .controlBackgroundColor)
        #else
        Color.gray.opacity(0.12)
        #endif
    }
}
