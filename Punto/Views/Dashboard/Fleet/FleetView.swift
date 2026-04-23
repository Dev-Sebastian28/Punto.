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
    
    init(user: User) {
        self.searchText = ""
        self.hideHeader = false
        self.vm = .init(user: user)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            vehiclesList
            FleetControlPanel(vm: vm)
        }.ignoresSafeArea(edges: [.top, .bottom])
    }
    
    private var vehiclesList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(vm.vehicles, id: \.vehicleInformation.id) { vehicle in
                FleetVehicleCard(vehicle: vehicle)
                    .padding(.horizontal, 9)
            }
        }.padding(.top, 100)
    }
}


#Preview {
    FleetView(user: .mock)
        .environment(NavigationRouter())
}
