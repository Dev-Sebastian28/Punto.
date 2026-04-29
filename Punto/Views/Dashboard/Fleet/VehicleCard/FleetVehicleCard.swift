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
            vehicleInformation
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
    
    private var vehicleInformation: some View {
        Image(vm.vehicleImage)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .bottomLeading) {
                VStack (alignment: .leading) {
                    
                    // Start Working, button to DriverControlPanel
                    if !vm.isWorking {
                        NavigationLink {
                            DriverControlPanel(vehicle: vm.vehicle)
                        } label: {
                            HStack(spacing: 12) {
                                Text("Start working")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Image(systemName: "road.lanes")
                                    .font(.title3)
                                    .padding(8)
                                    .background(Color.brandGreen)
                                    .clipShape(.circle)
                            }
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                            .padding(.trailing, 8)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color.myBlue)
                                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                            )
                        }
                    }
                    
                    
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(vm.brandModel)
                                .font(.title2.bold())
                            Text(vm.licensePlate)
                            
                            
                        }
                        Spacer()
                        
                        Text(vm.isWorking ? "Active" : "Inactive")
                            .font(.subheadline)
                            .foregroundStyle(vm.isWorking ? Color.white : Color.black).bold()
                            .padding(.horizontal, 13)
                            .padding(.vertical, 5)
                            .background(vm.isWorking ? Color.brandGreen : Color.platformGray6)
                            .clipShape(.capsule)
                    }
                    
                }
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.vertical)
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
    FleetVehicleCard(vehicle: User.mock.vehicles.first!)
        .environment(AppCoordinator(appState: AppState()))
}
