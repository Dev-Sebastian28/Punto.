//
//  AddVehicleView.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/02/26.
//

import SwiftUI

enum AddVehicleViewMode {
    case firstTime
    case addNew
}

struct AddVehicleView: View {
    let mode: AddVehicleViewMode
    
    @State private var isAddVehiclePresented = false
    @State private var showMessage: Bool = false
    
    @State private var vm: AddVehicleViewModel
    @Environment(AppCoordinator.self) var coordinator
    
    
    init(appState: AppState, mode: AddVehicleViewMode) {
        _vm = State(wrappedValue: AddVehicleViewModel(appState: appState))
        self.mode = mode
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.platformGroupedBackground.ignoresSafeArea(edges: [.top, .bottom])

            VStack(alignment: .center) {
                if mode == .firstTime {
                    header
                } else {
                    Spacer()
                }
                
                if vm.hasVehicle {
                    ScrollView(.vertical, showsIndicators: false) {
                        vehicleInfoSection
                        DButtonComp(
                            text: "Add New Vehicle",
                            color: .blue,
                            image: "plus") {
                                coordinator.onBoardingCoordinator.addVehicleCoordinator.didSelectCreate()
                            }
                    }
                    
                } else {
                    EmptyStateVehicleCard()
                }
                Spacer()
            }.padding(.horizontal)
            
            if vm.isLoading {
                ZStack {
                    Color.platformGroupedBackground.ignoresSafeArea()
                    
                    VStack(spacing: 24) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "car.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(.blue)
                        }
                        
                        VStack(spacing: 6) {
                            Text("Creating vehicle")
                                .font(.title3.weight(.semibold))
                            Text("This will only take a moment")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        ProgressView()
                            .tint(.blue)
                    }
                }
            }
            
            if showMessage {
                if let message = vm.message {
                    Color.platformGroupedBackground.ignoresSafeArea()
                    MessageToast(isPresented: $showMessage, message: message)
                }
            }
            
        }
        .onChange(of: vm.message) { _, newMessage in
            guard newMessage != nil else { return }
            showMessage = true
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                showMessage = false
                vm.message = nil
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
    let appState = AppState()
    AddVehicleView(appState: appState, mode: .addNew)
        .environment(AppCoordinator(appState: appState))
}
