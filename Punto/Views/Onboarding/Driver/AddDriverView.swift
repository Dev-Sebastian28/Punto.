//
//  AddDriverView.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/04/26.
//

import SwiftUI

struct AddDriverView: View {
    var vm: AddDriverViewModel
    @State private var selectedVehicleIndex: Int
    @State private var isAddDriverPresented: Bool = false
    @Environment(NavigationRouter.self) var router
    
    init(user: User) {
        vm = .init(user: user)
        self.selectedVehicleIndex = 0
        self.isAddDriverPresented = false
    }
    
    var body: some View {
        ZStack {
            VStack {
                header
                content
            }.sheet(isPresented: $isAddDriverPresented) {
                AddDriverForm(vm: vm, index: selectedVehicleIndex)
                    .presentationBackground(.white)
                    .presentationDetents([.height(310)])
            }
        }.padding(.horizontal, 10)
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top) {
                Image(systemName: "person.badge.plus")
                    .font(.title3)
                    .foregroundColor(.green)
                    .padding(14)
                    .background(
                        Color.green.opacity(0.15)
                            .clipShape(Circle())
                    )
                
                
                Text("Invite drivers to your fleet")
                    .font(.system(.title3, design: .rounded)).bold()
                Spacer()
                
                LaterButton
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Invite a new driver to your fleet to start managing their tasks, protocols and more.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("You can also be the driver of your own vehicle")
                    .underline()
            }
        }.padding(.horizontal)
    }
    private var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(vm.vehicles.enumerated(), id: \.element.vehicleInformation.id) { index, vehicle in
                VStack(alignment: .leading) {
                    vehicleCard(info: vehicle.vehicleInformation)
                    HStack(alignment: .center) {
                        Button {
                            selectedVehicleIndex = index
                            isAddDriverPresented.toggle()
                            
                        } label: {
                            
                            VStack(spacing: 0) {
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .font(.largeTitle)
                                    .foregroundStyle(Color.green)
                                Text("Add New")
                                    .font(.caption.bold())
                                    .foregroundStyle(.green)
                                
                            }
                            .buttonStyle(.plain)
                            .padding(12)
                            .background(
                                Color.green.opacity(0.15)
                                    .cornerRadius(10)
                            )
                        }
                        
                        Divider()
                            .frame(height: 70)
                        
            
                            if vm.user.vehicles[index].drivers.isEmpty {
                                VStack {
                                    Text("This vehicle has no drivers yet")
                                    Image(systemName: "person.crop.circle")
                                        .font(.largeTitle)
                                }.foregroundStyle(Color.secondary)
                                
                            } else {
                                
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(vehicle.drivers, id: \.name) { driver in
                                            DriverCardView(driver: driver)
                                            
                                        }
                                    }
                                }
                            }
                        
                    }
                }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.gray, lineWidth: 1)
                )
            }
        }
    }
    private var LaterButton: some View {
        Button {
            router.showMainTabs()
        } label: {
            VStack {
                Text("Add Later")
                    .font(.system(size: 15).weight(.semibold))
                    .foregroundStyle(.gray)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(Color.gray.opacity(0.15))
                    )
            }
        }
    }
    
}

#Preview {
    AddDriverView(user: .mock)
        .environment(NavigationRouter())
}
