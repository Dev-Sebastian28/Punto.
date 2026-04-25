//
//  FieldErrorLabel.swift
//  Punto
//
//  Created by Sebastian Garcia on 25/04/26.
//


//
//  FieldErrorLabel.swift
//  Punto
//

import SwiftUI

/// Componente reutilizable para mensajes de error inline en formularios
struct FieldErrorLabel: View {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var body: some View {
        Label(message, systemImage: "exclamationmark.circle.fill")
            .font(.caption.weight(.medium))
            .foregroundStyle(.red)
            .padding(.vertical, 2)
            .transition(.opacity.combined(with: .move(edge: .top)))
    }
}