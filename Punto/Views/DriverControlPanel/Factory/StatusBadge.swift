//
//  StatusBadge.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//


import SwiftUI

struct StatusBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.caption.bold())
            .foregroundStyle(.white)
            .padding(.vertical, 2)
            .padding(.horizontal, 12)
            .background(
                Capsule()
                    .fill(color.opacity(0.5))
                    .stroke(color)
            )
    }
}

struct DateBadge: View {
    let date: Date

    var body: some View {
        Text(date.formatted(.dateTime.day().month()))
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .background(Capsule().stroke(.blue))
    }
}
