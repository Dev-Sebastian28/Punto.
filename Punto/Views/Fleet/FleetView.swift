//
//  FleetView.swift
//  Punto
//
//  Created by Sebastian Garcia on 23/03/26.
//

import SwiftUI

struct FleetView: View {
    @State private var searchText: String = ""
    @State private var hideHeader: Bool = false
    @State private var vm: FleetViewModel
    
    @Environment(AppCoordinator.self) var coordinator
    
    init(appState: AppState) {
        self.vm = FleetViewModel(appState: appState)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if vm.hasVehicles {
                vehiclesList
                    .padding(.horizontal, 2)
                FleetControlPanel(vm: vm)
            } else {
                FleetEmptyState()
            }
        }.ignoresSafeArea(edges: [.top, .bottom])
    }
    
    private var vehiclesList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(vm.vehicles, id: \.vehicleInformation.id) { vehicle in
                FleetVehicleCard(vehicle: vehicle)
            }
        }.padding(.top, 100)
    }
    
}

#Preview {
    FleetView(appState: AppState())
        .environment(AppCoordinator(appState: AppState()))
}
