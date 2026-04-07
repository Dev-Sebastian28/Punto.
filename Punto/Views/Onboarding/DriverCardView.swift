//
//  DriverCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct DriverCardView: View {
    var driverName: String
    var driverNumber: String
    var driverMail: String

    private var initials: String {
        let parts = driverName.split(separator: " ")
        let prefix = parts.prefix(2).compactMap { $0.first }
        return prefix.isEmpty ? "DR" : String(prefix)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            Divider()
                .overlay(Color.cardStroke)
            contactBlock(systemImage: "envelope.fill", label: "Correo", value: driverMail)
            contactBlock(systemImage: "phone.fill", label: "Telefono", value: driverNumber)
        }
        .padding(16)
        .frame(maxWidth: 220, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.surfacePrimary)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 8)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.cardStroke, lineWidth: 1)
        }
    }

    private var header: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.brandBlue, .brandBlueDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 54, height: 54)

                Text(initials.uppercased())
                    .font(.headline.weight(.black))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(driverName)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text("Conductor")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.brandBlue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.brandBlue.opacity(0.12))
                    .clipShape(Capsule())
            }
        }
    }

    private func contactBlock(systemImage: String, label: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: systemImage)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(Color.brandBlue)
                .frame(width: 32, height: 32)
                .background(Color.brandBlue.opacity(0.10))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(label.uppercased())
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }

            Spacer()
        }
    }
}

#Preview {
    DriverCardView(
        driverName: "Sebastian Garcia",
        driverNumber: "123456789",
        driverMail: "sebastian.garcia@example.com"
    )
}
