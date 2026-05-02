//
//  FleetEmptyState.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/05/26.
//

import SwiftUI

struct FleetEmptyState: View {
    private let vehicleSymbols: [(symbol: String, color: Color)] = [
        ("car.fill", .brandBlue),
        ("truck.box.fill", .brandAmber),
        ("steeringwheel", .brandGreen),
        ("wrench.and.screwdriver.fill", .orange)
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 33) {
            HStack(spacing: 12) {
                ForEach(Array(vehicleSymbols.enumerated()), id: \.offset) { item in
                    Image(systemName: item.element.symbol)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(item.element.color)
                        .genericRoundedBackground(color: item.element.color.opacity(0.2))
                }
            }
            
            VStack(alignment: .center, spacing: 2) {
                    Text("Add your first vehicle")
                    Text("or")
                    .foregroundStyle(.secondary)
                    Text("Send a accept a vehicle invitation")
            }
            .font(.title3.weight(.bold))
            .foregroundStyle(.primary)
            
            VStack(spacing: 10) {
                DButtonComp(
                    text: "Addd First Vehicle",
                    color: .green,
                    image: "car.fill",
                    maxWidth: .infinity
                ) {
                    
                }
                DButtonComp(
                    text: "Accept Invitation",
                    color: .blue,
                    image: "",
                    maxWidth: .infinity
                ) {
                    
                }
                
            }
        }
    }
}

#Preview {
    FleetEmptyState()
}
