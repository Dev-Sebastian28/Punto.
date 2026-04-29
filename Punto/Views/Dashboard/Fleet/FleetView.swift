//
//  FleetView.swift
//  Punto
//
//  Created by Sebastian Garcia on 23/03/26.
//

import SwiftUI

struct FleetView: View {
    @State private var searchText: String
    @State private var hideHeader: Bool
    @State private var vm: FleetViewModel
    @Environment(AppCoordinator.self) var coordinator
    
    init(user: User) {
        self.searchText = ""
        self.hideHeader = false
        self.vm = FleetViewModel(user: user)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if vm.hasVehicles {
                vehiclesList
                FleetControlPanel(vm: vm)
            } else {
                VStack {
                    Image(systemName: "car")
                        .font(.system(size: 70))
                    Text("No vehicles added yet")
                        .font(.title)
                    Text("Add a new vehicle to get started")
                        .foregroundStyle(.secondary) 
                        .padding(.bottom)
                    
                    NavigationLink {
                        // Todo create a addVehicle View
                    } label: {
                        Text("Add a new vehicle")
                            .foregroundColor(.white)
                            .customBackground(color: .blue)
                    }
                }
            }
        }.ignoresSafeArea(edges: [.top, .bottom])
    }
    
    private var vehiclesList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(vm.vehicles, id: \.vehicleInformation.id) { vehicle in
                FleetVehicleCard(vehicle: vehicle).padding(.horizontal, 9)
            }
        }.padding(.top, 100)
    }
    
}

#Preview {
    FleetView(user: .mock)
        .environment(AppCoordinator(appState: AppState()))
}
