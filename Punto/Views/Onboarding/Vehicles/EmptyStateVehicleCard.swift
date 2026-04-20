//
//  EmptyStateVeihicleCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/04/26.
//
import SwiftUI

struct  EmptyStateVehicleCard: View {
    private let vehicleSymbols: [(symbol: String, color: Color)] = [
        ("car.fill", .brandBlue),
        ("truck.box.fill", .brandAmber),
        ("steeringwheel", .brandGreen),
        ("wrench.and.screwdriver.fill", .orange)
    ]
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 22) {
            HStack(spacing: 12) {
                ForEach(Array(vehicleSymbols.enumerated()), id: \.offset) { item in
                    Image(systemName: item.element.symbol)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(item.element.color)
                        .frame(maxWidth: .infinity)
                        .frame(height: 62)
                        .background(item.element.color.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Add your first vehicle")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.primary)
                
                Text("Enter your vehicle's information manually or use your property card to scan the vehicle's information.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            VStack(spacing: 12) {
                emptyStateInfo(
                    title: "Manual setup ",
                    description: "Register the core vehicle information in a few steps."
                )
                
                emptyStateInfo(
                    title: "Property card  (recommended)",
                    description: "Use your property card to scan the vehicle's information."
                )
            }
            
            VStack(spacing: 10) {
                DButtonComp(
                    text: "Property Card",
                    color: .green,
                    image: "camera.fill",
                    maxWidth: .infinity
                ) {
                    isPresented = true
                    
                }
                
                DButtonComp(
                    text: "Add vehicle manually ",
                    color: .gray,
                    image: nil,
                    style: .neutral,
                    maxWidth: .infinity
                ) {
                    isPresented = true
                }
            }
        }
        .padding(22)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.platformSystemBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(Color.cardStroke, lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.06), radius: 18, x: 0, y: 10)
    }
}

private func emptyStateInfo(title: String, description: String) -> some View {
    HStack(alignment: .top, spacing: 12) {
        Image(systemName: "checkmark.circle.fill")
            .font(.headline)
            .foregroundStyle(.blue)
        
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
            Text(description)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        
        Spacer(minLength: 0)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(14)
    .background(Color.platformGray6)
    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
}

#Preview {
    EmptyStateVehicleCard(isPresented: .constant(true))
}
