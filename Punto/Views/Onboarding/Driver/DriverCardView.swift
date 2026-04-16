//
//  DriverCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct DriverCardView: View {
    let driver: DriverInvitation
    private var initials: String {
        let parts = driver.name.split(separator: " ")
        let prefix = parts.prefix(2).compactMap { $0.first }
        return prefix.isEmpty ? "DR" : String(prefix)
    }
    private var style: Color {
        switch driver.status {
        case .pending:
                .gray
        case .accepted:
                .green
        case .rejected:
                .red
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            header
        
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Image(systemName: "number")
                    Text(driver.email)
                }
                
                HStack {
                    Image(systemName: "at")
                    Text(driver.phone)
                }
            }
            .font(.caption2)
            .foregroundStyle(.secondary)

        }
        .padding(8)
        .frame(maxWidth: 220, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.surfacePrimary)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.cardStroke, lineWidth: 1)
        }
    }

    private var header: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.brandBlue, .brandBlueDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    ).frame(width: 34, height: 34)

                Text(initials.uppercased())
                    .font(.caption.weight(.black))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(driver.name)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Text(driver.status.rawValue)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(style)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .background(style.opacity(0.18))
                    .clipShape(Capsule())
            }
            Spacer()
        }
    }

    
//    private func contactBlock(systemImage: String, label: String, value: String) -> some View {
//        HStack(alignment: .top, spacing: 10) {
//            Image(systemName: systemImage)
//                .font(.subheadline.weight(.bold))
//                .foregroundStyle(Color.brandBlue)
//                .frame(width: 32, height: 32)
//                .background(Color.brandBlue.opacity(0.10))
//                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//
//            VStack(alignment: .leading, spacing: 2) {
//                Text(label.uppercased())
//                    .font(.caption2.weight(.bold))
//                    .foregroundStyle(.secondary)
//
//                Text(value)
//                    .font(.subheadline.weight(.medium))
//                    .foregroundStyle(.primary)
//                    .multilineTextAlignment(.leading)
//                    .lineLimit(2)
//            }
//
//            Spacer()
//        }
//    }
}

#Preview {
    DriverCardView(driver: .init(name: "Sebastian Garcia", email: "123456789", phone: "sebastian.garcia@example.com", status: .accepted))
}
