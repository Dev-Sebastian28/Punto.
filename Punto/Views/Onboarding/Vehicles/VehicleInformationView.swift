//
//  VehicleInformationView.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/03/26.
//

import SwiftUI

struct VehicleInformationView: View {
    var vehicle: Vehicle
    
    private var info: VehicleInformation {
        vehicle.vehicleInformation
    }
    
    private var vehicleTypeLabel: String {
        vehicle is TransportationVehicle ? "Transporte" : "Privado"
    }
    
    private var vehicleTypeColor: Color {
        vehicle is TransportationVehicle ? .blue : .green
    }

    private var yearText: String {
        String(info.year)
    }

    private var mileageText: String {
        "\(info.mileage.formatted(.number.grouping(.automatic))) km"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            imageHeader
            titleSection
            detailsGrid
            
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.surfacePrimary)
                .shadow(color: Color.black.opacity(0.08), radius: 14, x: 0, y: 8)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.cardStroke, lineWidth: 1)
        }
    }
    
    private var imageHeader: some View {
        ZStack(alignment: .topLeading) {
            Image(info.image)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(alignment: .bottomLeading) {
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.55)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(info.brand) \(info.model)")
                            .font(.title2.bold())
                        Text(info.plate)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .foregroundStyle(.white)
                    .padding(16)
                }
            
            Text(vehicleTypeLabel)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(vehicleTypeColor)
                .clipShape(Capsule())
                .padding(14)
        }
    }
    
    private var titleSection: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text(yearText)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            plateBadge
        }
    }
    
    private var plateBadge: some View {
        HStack(spacing: 19) {
            Text("PLACA")
                .font(.caption2.weight(.bold))
                .foregroundStyle(.secondary)
            
            Text(info.plate)
                .font(.headline.weight(.bold))
                .foregroundStyle(.primary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.platformGray6)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    
    private var detailsGrid: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                vehicleRowCard(image: "gearshape.2.fill", title: "Transmision", description: info.transmission.rawValue, tint: .orange)
                vehicleRowCard(image: "fuelpump.fill", title: "Combustible", description: info.fuel.rawValue, tint: .green)
            }
            
            HStack(spacing: 10) {
                vehicleRowCard(image: "engine.combustion.fill", title: "Motor", description: info.engine, tint: .red)
                vehicleRowCard(image: "gauge.with.dots.needle.50percent", title: "Kilometraje", description: mileageText, tint: .blue)
            }
        }
    }
}

private func vehicleRowCard(image: String, title: String, description: String, tint: Color) -> some View {
        HStack {
            
            Image(systemName: image)
                .font(.headline.weight(.bold))
                .foregroundStyle(tint)
                .frame(width: 44, height: 44)
                .background(tint.opacity(0.14))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text(description)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                Text(title)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            
        }
        .frame(maxWidth: .infinity, minHeight: 38, alignment: .topLeading)
        .padding(14)
        .background(Color.platformGray6)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    
}

#Preview {
    VehicleInformationView(
        vehicle: TransportationVehicle(
            vehicleInformation: .init(
                id: .init(),
                image: "volvo",
                plate: "DMW-243",
                brand: "Volvo",
                model: "X700x",
                year: 2000020,
                mileage: 100000,
                engine: "V8",
                transmission: .automatic,
                fuel: .diesel
            )
        )
    )
}
