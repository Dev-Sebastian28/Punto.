//
//  InfoRow.swift
//  Punto
//
//  Created by Sebastian Garcia on 6/05/26.
//
import SwiftUI

struct InfoRow: View {
    let label: String
    let value: String
    var isTag: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            if isTag {
                Text(value)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            } else {
                Text(value)
                    .font(.subheadline.weight(.medium))
            }
        }
    }
}
