//
//  CarQuickView.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//
import SwiftUI


struct VehicleQuickView: View {
    let vehicle: VehicleInformation
    var quickSummary : [QuickSummary]
    let selectedColor: Color
    var isSelected: Bool = true
    var body: some View {
        VStack(spacing: -2) {
            if isSelected {
                Text("Selected")
                    .foregroundStyle(.white).bold()
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                    .background(
                        selectedColor.opacity(0.8)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    )
            }
            VStack {
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .top, spacing: 8) {
                        ZStack {
                            VehicleImageView(imageUrl: vehicle.imageUrl, height: 80, cornerRadius: 12)

                        }
                        vehicleInfo
                    }
                    
                    Divider()
            
                    HStack {
                        ForEach(quickSummary, id: \.title) { summary in
                            StatPill(title: summary.title, value: summary.value, color: summary.color)
                        }
                    }.font(.footnote)
                }.padding(10)
            }.background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(isSelected ? selectedColor : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 0)
                    )
                    .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
            }
        }
    }
    
    private var vehicleInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(vehicle.brand + " " + vehicle.model )
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(vehicle.plate)
            
            Text( "Year: "  + vehicle.year.description)
            
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
}

private struct StatPill: View {
    let title: String
    let value: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                Text("\(value)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.primary.opacity(0.05))
        )
    }
}



#Preview {
    VehicleQuickView(
        vehicle: VehicleInformation.sample,
        quickSummary: [],
        selectedColor: .brandAmber
    )
}
