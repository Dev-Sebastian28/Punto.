//
//  CarQuickView.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//
import SwiftUI


struct CarQuickView: View {
    var vehicle: VehicleInformation
    var quickSummary : [QuickSummary2]
    var selectedColor: Color
    var isSelected: Bool = true
    var body: some View {
        VStack (spacing: -0){
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
                
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Image(vehicle.image)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 96, height: 68)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(vehicle.brand + " " + vehicle.model )
                                .font(.headline)
                                .foregroundStyle(.primary)
         
                            Text(vehicle.plate)
                     
                            Text( "Year: "  + vehicle.year.description)
                            
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        Spacer(minLength: 0)
                    }
                    
                    Divider()
                        .padding(.horizontal, 2)
                    
                    HStack(spacing: 10) {
                        ForEach(quickSummary, id: \.title) { summary in
                            StatPill(title: summary.title, value: summary.value, color: summary.color)
                        }
                    }
                    .font(.footnote)
                }
                
                .padding(12)
            }
            .frame(width: 240, height: 150)
        }
    }
}

private struct StatPill: View {
    let title: String
    let value: Int
    let color: Color

    
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
    CarQuickView(vehicle: DummyData().dummyDataVehicleInformation(), quickSummary: [.init(title: "Done", value: 0, color: .green), .init(title: "Not Done", value: 0, color: .red)], selectedColor: .red)
}
