//
//  AddVehicleView.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/02/26.
//

import SwiftUI

struct AddVehicleView: View {
    @State private var isAddVehiclePresented = false
    @State private var vm: AddVehicleViewModel
    @State private var showMessage: Bool = false
    @Environment(AppCoordinator.self) var coordinator
    
    
    init(user: User) {
        _vm = State(wrappedValue: AddVehicleViewModel(user: user))
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    
                    if vm.hasVehicle {
                        vehicleInfoSection
                        DButtonComp(
                            text: "Add New Vehicle",
                            color: .blue,
                            image: "plus") {
                                isAddVehiclePresented.toggle()
                            }
                    } else {
                        EmptyStateVehicleCard(isFormPresented: $isAddVehiclePresented)
                    }
                    
                }.padding(.horizontal, 16)
            }
            .background(Color.platformGroupedBackground)
            .sheet(isPresented: $isAddVehiclePresented) {
                AddVehicleForm(vm: self.vm)
            }
            
            if showMessage {
                if let message = vm.message {
                    MessageToast(message: message)
                }
            }
            
            if vm.isLoading {
                Color.white
                ProgressView()
            }
            
        }.onChange(of: vm.message) { _, _ in
            presentMessage()
        }
    }
    private func presentMessage() {
        showMessage = true
        Task {
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            showMessage = false
            
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
                        
                        navigationButton
                        
                    }
                    
                    Text("Add vehicles now and connect them later with drivers, tasks and maintenance tracking and much more services.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                }
            }
        }
    }
    
    private var vehicleInfoSection: some View {
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
    
    private var navigationButton: some View {
        Button {
            if vm.hasVehicle {
                coordinator.onBoardingCoordinator.navigate(to: .addDriver)
            } else {
                coordinator.onBoardingCoordinator.didFinishOnBoarding()
            }
        } label: {
            
            Text(vm.hasVehicle ?  "Add Drivers" : "Add Later")
                .font(.caption2.weight(.bold))
                .foregroundStyle(vm.hasVehicle ? .green : .secondary )
                .genericCapsuleBackground(color: vm.hasVehicle ? .green.opacity(0.1) : .secondary.opacity(0.1))
        }.buttonStyle(.plain)
    }
}


#Preview {
    AddVehicleView(user: .mock)
        .environment(AppCoordinator(appState: AppState()))
}
