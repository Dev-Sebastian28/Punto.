//
//  CargoDescription.swift
//  Punto
//
//  Created by Sebastian Garcia on 6/05/26.
//
import SwiftUI


// MARK: - Cargo Description
struct CargoDescription: View {
    let cargo: Cargo
    var body: some View {
        VStack(alignment: .leading) {
            CardHeader(icon: "shippingbox.fill", title: "Cargo Information", color: .blue)

            InfoRow(label: "Type", value: "\(cargo.cargoType)", isTag: true)
            InfoRow(label: "Weight", value: "\(cargo.weightKg)")

            Divider()

            InfoRow(label: "Dimensions", value: "\(cargo.volumeCubicMeters)m")

            Divider()

            DescriptionBlock(
                icon: "text.alignleft",
                text: "\(String(describing: cargo.origin))."
            )
        }.genericRoundedBackgroundShadow(color: .gray)
    }
}

#Preview {
    CargoDescription(cargo: .mockPending)
}
