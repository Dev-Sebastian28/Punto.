//
//  AddVehicleView.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/02/26.
//

import SwiftUI

struct AddVehicleView: View {
    var user: User
    @State private var isAddVehiclePresented = false
    @Environment(NavigationRouter.self) private var router
    private let vehicleSymbols: [(symbol: String, color: Color)] = [
        ("car.fill", .brandBlue),
        ("truck.box.fill", .brandAmber),
        ("steeringwheel", .brandGreen),
        ("wrench.and.screwdriver.fill", .orange)
    ]

    private var hasVehicles: Bool {
        !user.vehicles.isEmpty
    }

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header

                    if hasVehicles {
                        vehicleListSection
                    } else {
                        emptyStateCard
                    }
                }
                .padding(.horizontal, 16)
            }
            .background(Color.platformGroupedBackground)
            .sheet(isPresented: $isAddVehiclePresented) {
                AddVehicleForm(isAddVehiclePresented: $isAddVehiclePresented)
                
            }
            
            VStack {
                Spacer()
                DButtonComp(
                    text: "Add New Vehicle",
                    color: .blue,
                    image: "plus",
                    maxWidth: 190,
                    maxHeight: 26) {
                        
                    }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Set up your fleet")
                            .font(.largeTitle.weight(.bold))
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        laterButton

                    }
                    
                    Text("Add vehicles now and connect them later with drivers, tasks and maintenance tracking and much more services.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                }
            }
        }
    }
    private var vehicleListSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Your vehicles:")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Text("Total: \(user.vehicles.count)")
            }

            LazyVStack(spacing: 14) {
                ForEach(user.vehicles, id: \.vehicleInformation.id) { vehicle in
                    VehicleInformationView(vehicle: vehicle)
                }
            }
        }
    }
    
    private var emptyStateCard: some View {
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
                    isAddVehiclePresented = true

                }

                DButtonComp(
                    text: "Add vehicle manually ",
                    color: .gray,
                    image: nil,
                    style: .neutral,
                    maxWidth: .infinity
                ) {
                    isAddVehiclePresented = true
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
    private var laterButton: some View {
        Button {
            router.showMainTabs()
        } label: {
            
            Text(hasVehicles ?  "Add Drivers" : "Add Later")
                .font(.caption2.weight(.bold))
                .foregroundStyle(hasVehicles ? .green : .secondary )
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(hasVehicles ? .green.opacity(0.1) : .secondary.opacity(0.1))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddVehicleView(user: .mock)
        .environment(NavigationRouter())
}
