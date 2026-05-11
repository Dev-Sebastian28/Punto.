//
//  CargoDetailView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/04/26.
//

// CargoDetailView.swift

import SwiftUI

struct CargoDetailView: View {
    private let cardStyle = LinearGradient(
        colors: [Color.blue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    let cargo: Cargo
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                header
                VStack(spacing: 12) {
                    CargoRouteDetail(cargo: cargo)
                    CargoDescription(cargo: cargo)
                    CargoVehicleRequirements()
                    CargoDueDateView(cargo: cargo)
                    
                    HStack {
                        DButtonComp(text: "Request Cargo", color: .blue, image: "") {
                            
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(.systemGroupedBackground))
    }
    
    private var header: some View {
            ZStack(alignment: .topLeading) {
                // Background gradient
                cardStyle

                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    
                    HStack(alignment: .top,spacing: 10) {
                        Image(systemName: "shippingbox.fill")
                            .font(.system(size: 17))
                            .genericRoundedBackground(color: .white.opacity(0.18))

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Cargo Name:" + " " + cargo.cargoName)
                                .font(.title3.weight(.semibold))
                            Text(cargo.id.uuidString)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.7))
                        }
                    }.foregroundStyle(.white)


                    
                }
                .padding(.top, 56)
                .padding(.horizontal)
                .padding(.bottom, 24)
            }.frame(maxWidth: .infinity)
    }
    
    private var mapPlaceholder: some View {
    // Map
    RoundedRectangle(cornerRadius: 12)
        .fill(.white.opacity(0.1))
        .frame(height: 90)
        .overlay(
            Label("\(cargo.origin) → \(cargo.destination)", systemImage: "map")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white.opacity(0.2), lineWidth: 0.5)
        )
}
}

#Preview {
    CargoDetailView(cargo: .mockPending)
}

