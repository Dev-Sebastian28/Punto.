//
//  CargoCardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//

import SwiftUI

struct CargoCardView: View {
    let cargoInfo: Cargo
    @Environment(AppCoordinator.self) var coordinator


    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // MARK: - Header
            VStack(alignment: .leading, spacing: 4) {
                Text("Available Cargo of:")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                    .tracking(0.5)

                Text(cargoInfo.cargoType)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            

            // MARK: - Route
            HStack(alignment: .center, spacing: 12) {

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
                        address: cargoInfo.origin,
                        color: .green
                    )

                    Spacer().frame(height: 12)

                    RouteStopView(
                        label: "Destino",
                        address: cargoInfo.destination,
                        color: .red
                    )
                }
                
                Spacer()
                
                VStack {
                    Label("T. Distance: " + "\(cargoInfo.destination) km", systemImage: "location.fill")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(.blue))

                    
                    Label("Able to carry", systemImage: "checkmark")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(.green))
                }
                .font(.caption).bold()
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(RoundedRectangle(cornerRadius: 10).fill(.blue.opacity(0.3)))


            }
            .padding(.horizontal, 16)
            .padding(.bottom, 14)

            // MARK: - Footer Divider
            Divider()
                .padding(.horizontal, 16)
            footer


        }.genericRoundedBackgroundShadow(color: .gray)
    }
    
    private var footer: some View {
        // MARK: - Footer
        HStack(spacing: 16) {
            Label("\(cargoInfo.weightKg) ton", systemImage: "scalemass.fill")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            Divider()
                .frame(height: 16)

            Label(cargoInfo.cargoType, systemImage: "shippingbox.fill")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            Spacer()

            Button {
                coordinator.cargoCoordinator.navigate(to: .details(cargo: cargoInfo))
            } label: {
                Text("Ver")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
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
    CargoCardView(cargoInfo: .mockPending)
        .environment(AppCoordinator(appState: AppState()))
}
