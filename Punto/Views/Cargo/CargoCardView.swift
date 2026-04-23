//
//  CargoCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//

import SwiftUI

struct CargoCardView: View {
    var cargo: Cargo

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // MARK: - Header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Carga disponible")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .tracking(0.5)

                    Text(cargo.type)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }

                Spacer()

                Label("\(cargo.distance) km", systemImage: "location.fill")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(.blue))
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 14)

            // MARK: - Route
            HStack(alignment: .top, spacing: 12) {

                // Timeline indicators
                VStack(spacing: 0) {
                    Circle()
                        .fill(.green)
                        .frame(width: 10, height: 10)
                        .padding(.top, 4)

                    Rectangle()
                        .fill(Color(.systemGray4))
                        .frame(width: 2)
                        .frame(maxHeight: 30)

                    Circle()
                        .strokeBorder(.red, lineWidth: 2)
                        .frame(width: 10, height: 10)
                        .padding(.bottom, 4)
                }
                .frame(width: 10)

                // Addresses
                VStack(alignment: .leading, spacing: 0) {
                    RouteStopView(
                        label: "Origen",
                        address: cargo.origine,
                        color: .green
                    )

                    Spacer().frame(height: 12)

                    RouteStopView(
                        label: "Destino",
                        address: cargo.destination,
                        color: .red
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 14)

            // MARK: - Divider
            Divider()
                .padding(.horizontal, 16)

            // MARK: - Footer
            HStack(spacing: 16) {
                Label("\(cargo.weight) ton", systemImage: "scalemass.fill")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)

                Divider()
                    .frame(height: 16)

                Label(cargo.type, systemImage: "shippingbox.fill")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)

                Spacer()

                Button {
                    // action
                } label: {
                    Text("Ver")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
        )
    }
}

// MARK: - Subview
struct RouteStopView: View {
    let label: String
    let address: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(color)
                .textCase(.uppercase)
                .tracking(0.4)

            Text(address)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .lineLimit(1)
        }
    }
}



#Preview {
    CargoCardView(cargo: Cargo(
        id: 1,
        origine: "Bogotá, Calle 2, Catedral",
        destination: "Bogotá, Calle 12, 10 de Julio",
        weight: 22,
        type: "Máquina Industrial",
        distance: 12
    ))
    .padding()
    .background(Color(.systemGroupedBackground))
}
