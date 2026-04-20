//
//  AddVehicleView.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/02/26.
//

import SwiftUI

struct AddVehicleView: View {
    @State private var isAddVehiclePresented = false
    @Environment(NavigationRouter.self) private var router
    @State private var vm: AddVehicleViewModel
    
    init(user: User) {
        self.isAddVehiclePresented = false
        _vm = State(wrappedValue: AddVehicleViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    if vm.hasVehicle {
                        vehicleListSection
                        DButtonComp(
                            text: "Add New Vehicle",
                            color: .blue,
                            image: "plus"
                            ) {
                                isAddVehiclePresented.toggle()
                            }
                    } else {
                        EmptyStateVehicleCard(isPresented: $isAddVehiclePresented)
                    }
                }.padding(.horizontal, 16)
            }
            .background(Color.platformGroupedBackground)
            .sheet(isPresented: $isAddVehiclePresented) {
                AddVehicleForm()
                
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
                
                Text("Total:" + vm.vehicleCount)
            }
            
            LazyVStack(spacing: 14) {
                ForEach(vm.vehicles, id: \.vehicleInformation.id) { vehicle in
                    VehicleInformationView(vehicle: vehicle)
                }
            }
        }
    }
    private var laterButton: some View {
        Button {
            if vm.hasVehicle {
                router.navigate(to: .addDriver)
            } else {
                router.showMainTabs()
            }
        } label: {
            
            Text(vm.hasVehicle ?  "Add Drivers" : "Add Later")
                .font(.caption2.weight(.bold))
                .foregroundStyle(vm.hasVehicle ? .green : .secondary )
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(vm.hasVehicle ? .green.opacity(0.1) : .secondary.opacity(0.1))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}



#Preview {
    AddVehicleView(user: .mock)
        .environment(NavigationRouter())
}
