//
//  Card.swift
//  Punto
//
//  Created by Sebastian Garcia on 29/03/26.
//

import SwiftUI

struct FleetVehicleCard: View {
    let vm: FleetVehicleCardViewModel
    @Environment(NavigationRouter.self) var router
    
    init(vehicle: Vehicle) {
        self.vm = .init(vehicle: vehicle)
    }
    
    var body: some View {
        VStack {
            vehicleInformation
            driverSection
            buttonsList
            
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 7)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.accentColor.opacity(0.2))
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(.blue, lineWidth: 1)
                }
        }
    }
    
    private var vehicleInformation: some View {
        Image(vm.vehicleImage)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .bottomLeading) {
                VStack (alignment: .leading) {
                    HStack {
                        Spacer()
                        Text(vm.isWorking ? "Active" : "Inactive")
                            .font(.title3)
                            .foregroundStyle(vm.isWorking ? Color.white : Color.black).bold()
                            .padding(.horizontal, 13)
                            .padding(.vertical, 5)
                            .background(vm.isWorking ? Color.brandGreen : Color.platformGray6)
                            .clipShape(.capsule)
                    }
                    
                    Spacer()
                    
                    Text(vm.brandModel)
                        .font(.title2.bold())
                    HStack {
                        Text("La blanca")
                        Text("-")
                        Text(vm.licensePlate)
                    }
                }
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.vertical)
            }
    }
    private var buttonsList: some View {
        HStack(spacing: 5) {
            QuickInfoButton(
                title: "Tasks",
                value: vm.pendingTask,
                image: "checklist",
                color: .blue) {
                    router.navigate(to: .tasks)
                }
            
            QuickInfoButton(
                title: "Protocols",
                value: vm.pendingProtocols,
                image: "shield",
                color: .brandAmber) {
                    router.navigate(to: .protocols)
                }
            
            QuickInfoButton(
                title: "Manten.",
                value: vm.maintenances,
                image: "wrench.fill",
                color: .brandBlueDark) {
                    router.navigate(to: .manteinances)
                }
            
            QuickInfoButton(
                title: "Expenses",
                value: vm.newExpeneses,
                image: "dollarsign",
                color: .brandGreen) {
                    router.navigate(to: .expenses)
                }
        }
    }
    private var driverSection: some View {
        HStack {
            HStack {
                if vm.hasDrivers && vm.isWorking {
                    driverInfo(for: vm.currentDriver)
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
            .padding(13)
            .background(.white)
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
            }.padding(.trailing, 13)
        }.background(
            Color.blue
                .clipShape(RoundedRectangle(cornerRadius: 15))
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
                        .font(.title3)
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
        .environment(NavigationRouter())
}
