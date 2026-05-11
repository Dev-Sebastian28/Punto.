//
//  DescriptionBlock.swift
//  Punto
//
//  Created by Sebastian Garcia on 6/05/26.
//
import SwiftUI

struct DescriptionBlock: View {
    let icon: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Descripción", systemImage: icon)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
        }
    }
}
