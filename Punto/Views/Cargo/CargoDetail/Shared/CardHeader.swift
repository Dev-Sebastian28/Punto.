//
//  CardHeader.swift
//  Punto
//
//  Created by Sebastian Garcia on 6/05/26.
//
import SwiftUI

struct CardHeader: View {
    let icon: String
    let title: String
    var color: Color = .blue

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 26, height: 26)
                .background(color.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            Text(title)
                .font(.subheadline.weight(.semibold))
        }
    }
}
