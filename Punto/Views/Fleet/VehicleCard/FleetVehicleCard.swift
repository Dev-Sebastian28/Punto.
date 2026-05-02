//
//  Card.swift
//  Punto
//
//  Created by Sebastian Garcia on 29/03/26.
//

import SwiftUI

struct FleetVehicleCard: View {
    let vm: FleetVehicleCardViewModel
    @Environment(AppCoordinator.self) var coordinator
    
    init(vehicle: Vehicle) {
        self.vm = .init(vehicle: vehicle)
    }
    
    var body: some View {
        VStack {
            sample
                .padding(.bottom, 6)
            driverSection
            buttonsList
            
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 7)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .fill(vm.isWorking ? Color.blue.opacity(0.4) : Color.gray.opacity(0.2))
                .stroke(vm.isWorking ? Color.blue : Color.gray, lineWidth: 1)
        }
    }
    private var  sample: some View {
        VehicleImageView(
            imageUrl: vm.vehicleImage,
            height: 200
        ) {
            VehicleNameOverlay(
                brand: vm.brandModel,
                model: vm.brandModel,
                plate: vm.licensePlate
            )
        }
    }
    
    private var driverSection: some View {
        HStack {
            HStack {
                if vm.hasDrivers && vm.isWorking {
                    driverInfo(for: vm.currentDriver ?? .init(name: "", email: "", phone: 0, status: .pending))
                    
                } else if vm.hasDrivers && !vm.isWorking {
                    ForEach(vm.drivers, id: \.name) { driver in
                        Text(driver.name)
                    }
                } else {
                    Image(systemName: "person.slash.fill")
                        .font(.title2)
                    Text("There are no drivers assigned to this vehicle (only you)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
            )
            
            // Navigation Button
            NavigationLink {
                
            } label: {
                VStack {
                    HStack (spacing: 0) {
                        Image(systemName: "person.3.fill")
                            .font(.title3)
                        
                        Image(systemName: "plus")
                            .font(.callout)
                        
                    }
                    Text("Add New")
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
                .bold()
            }.padding(.horizontal, 13)
        }.background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.6))
        )
    }
    
    private func driverInfo(for driver: DriverInvitation) -> some View {
        HStack {
            Text(vm.currentDriverInitials)
                .foregroundStyle(.white).bold()
                .frame(width: 41, height: 41)
                .background(Color.brandBlue)
                .clipShape(.circle)
            
            VStack (alignment: .leading) {
                Text("Driver")
                    .foregroundStyle(Color.textMuted)
                Text(driver.name)
                    .bold()
                    .foregroundStyle(Color.brandBlueDark)
            }
            Spacer()
        }
    }
    
    private var buttonsList: some View {
        HStack(spacing: 6) {
            QuickInfoButton(
                title: "Tasks",
                value: vm.pendingTask,
                image: "checklist",
                color: .blue) {
                    coordinator.fleetCoordinator.navigate(to: .tasks)
                }
            
            QuickInfoButton(
                title: "Protocols",
                value: vm.pendingProtocols,
                image: "shield",
                color: .brandAmber) {
                    coordinator.fleetCoordinator.navigate(to: .protocols)
                }
            
            QuickInfoButton(
                title: "Manten.",
                value: vm.maintenances,
                image: "wrench.fill",
                color: .brandBlueDark) {
                    coordinator.fleetCoordinator.navigate(to: .manteinances)
                }
            
            QuickInfoButton(
                title: "Expenses",
                value: vm.newExpeneses,
                image: "dollarsign",
                color: .brandGreen) {
                    coordinator.fleetCoordinator.navigate(to: .expenses)

                }
        }
    }
}

private struct QuickInfoButton: View {
    var title: String
    var value: Int
    var image: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button  {
            action()
            
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: image)
                        .foregroundStyle(color)
                    
                    Text("\(value)")
                        .font(.subheadline)
                        .bold()
                }
                
                Text(title)
                    .font(.default)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .stroke(color.opacity(0.7), lineWidth: 1)
            }
        }.foregroundStyle(.black)
    }
}



#Preview {
    FleetVehicleCard(vehicle: TransportationVehicle(vehicleInformation: .sample))
        .environment(AppCoordinator(appState: AppState()))
}
