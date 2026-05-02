//
//  VehicleDriversCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/05/26.
//
import SwiftUI

struct VehicleDriversCard: View {
    let vehicle: Vehicle
    let vm: AddDriverViewModel
    var index: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VehicleCard(info: vehicle.vehicleInformation)

            Divider()

            HStack(alignment: .center, spacing: 12) {
                // Add driver button
                addButton

                Divider()
                    .frame(height: 70)

                // Drivers list or empty state
                if vm.user.vehicles[index].drivers.isEmpty {
                    VStack(spacing: 6) {
                        Image(systemName: "person.crop.circle.dashed")
                            .font(.system(size: 28))
                            .foregroundStyle(.black)
                        Text("No drivers yet")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }.frame(maxWidth: .infinity)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vehicle.drivers, id: \.name) { driver in
                                DriverCardView(driver: driver)
                                    .transition(.scale(scale: 0.85).combined(with: .opacity))
                            }
                        }.padding(.horizontal, 4)
                    }
                }
            }
        }
    }
    
    private var addButton: some View {
        Button {
            isPresented.toggle()
        } label: {
            VStack(spacing: 6) {
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 18))
                    .foregroundStyle(.green)
                Text("Add New")
                    .font(.caption.bold())
                    .foregroundStyle(.green)
            }.genericRoundedBackground(color: .green.opacity(0.05))
        }.buttonStyle(.plain)
    }
}
