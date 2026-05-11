//
//  View+Ext.swift
//  Punto
//
//  Created by Sebastian Garcia on 9/04/26.
//

import Foundation
import SwiftUI

// MARK: - Shared View Modifiers
struct SharedRoundedBackground: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 16)
            .padding(.horizontal, 14)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SharedCapsuleBackground: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(color)
            .clipShape(.capsule)
    }
}

struct SharedRectangleBackground: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 18)
            .background(color)
    }
}

struct SharedRectangleBackgroundShadow: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: color.opacity(0.06), radius: 6, x: 0, y: 2)

    }
}




// MARK: - View Extension
extension View {
    
    func genericRoundedBackgroundShadow (color: Color) -> some View {
        modifier(SharedRectangleBackgroundShadow(color: color))
    }
    
    func genericRoundedBackground (color: Color) -> some View {
        modifier(SharedRoundedBackground(color: color))
    }
    
    func genericCapsuleBackground (color: Color) -> some View {
        modifier(SharedCapsuleBackground(color: color))
    }
    
    func genericRectangleBackground (color: Color) -> some View {
        modifier(SharedRectangleBackground(color: color))
    }
}
