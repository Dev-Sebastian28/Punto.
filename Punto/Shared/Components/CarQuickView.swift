//
//  CarQuickView.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//
import SwiftUI

struct CarQuickView: View {
    var vehicle: VehicleInformation
    var title1: String
    var value1: Int
    var title2: String
    var value2: Int
    var title3: String
    var value3: Int
    var selectedColor: Color
    var isSelected: Bool = true
    var body: some View {
        VStack (spacing: -2){
            if isSelected {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 87, height: 28)
                    .foregroundStyle(selectedColor)
                    .overlay {
                        Text("Selected")
                            .foregroundStyle(.white)
                            .bold()
                    }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(isSelected ? selectedColor : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 0)

                    )
                    .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)

                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Image(vehicle.image)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 96, height: 68)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 6) {
                                Text(vehicle.brand)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                Text(vehicle.model)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                            }
                            Text(vehicle.plate)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("Año \(vehicle.year)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer(minLength: 0)
                    }

                    Divider()
                        .padding(.horizontal, 2)

                    HStack(spacing: 10) {
                        StatPill(color: .blue, title: title1, value: value1)
                        StatPill(color: .red, title: title2, value: value2)
                        StatPill(color: .green, title: title3, value: value3)
                    }
                    .font(.footnote)
                }

                .padding(12)
            }
            .frame(width: 240, height: 150)
            .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(vehicle.brand) \(vehicle.model), placa \(vehicle.plate)")
        }
    }
}

private struct StatPill: View {
    let color: Color
    let title: String
    let value: Int

    var body: some View {
        HStack(spacing: 1) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            VStack(alignment: .center, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("\(value)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.primary.opacity(0.05))
        )
    }
}

#Preview {
    CarQuickView(vehicle: .init(id: .init(), image: "volvo", plate: "", brand: "", model: "", year: 1, mileage: 1, engine: "", transmission: .automatic, fuel: .diesel), title1: "", value1: 1, title2: "", value2: 1, title3: "", value3: 1, selectedColor: .yellow)
}
