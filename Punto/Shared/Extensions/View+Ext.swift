//
//  View+Ext.swift
//  Punto
//
//  Created by Sebastian Garcia on 9/04/26.
//

import Foundation
import SwiftUI

struct CustomBackground: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(color.opacity(0.5))
            .cornerRadius(10)
    }
}

extension View {
    func customBackground (color: Color) -> some View {
        modifier(CustomBackground(color: color))
    }
}
