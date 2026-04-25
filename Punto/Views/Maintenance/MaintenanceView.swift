//
//  MaintenanceView.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/03/26.
//

import SwiftUI

struct MaintenanceView: View {
    @State private var vm: MaintenanceViewModel
    
    init(user: User) {
        _vm = State(wrappedValue: MaintenanceViewModel(user: user))
    }
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 10) {
            
            HeaderComp(
                title: "Maintenances" ,
                image: "wrench.and.screwdriver.fill",
                description: "Welcome to maintenance, here you can monitor your vehicle maintenances and add new ones",
                color: .blue,
                gradient: .none
            )
            
            CarouselComp(
                strategy: MaintenanceCarouselAlgorithm(),
                color: .blue,
                selectedIndex: $vm.selectedVehicleIndex
            )
            
            MaintenanceFilterView(
                millage: vm.currentVehicleRange,
                totalParts:vm.totalVehicleMaintenances
            )
            
            maintenancesList
            
        }
        .ignoresSafeArea(edges: .bottom)
        .padding(.horizontal, 8)
    }
    private var maintenancesList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(vm.components, id: \.id) { part in
                MaintenanceCard(part: MaintenaceDataTransfer().perform(comp: part))
                    .padding(.top, 5)
                    .padding(.horizontal, 5)
                
            }
        }
    }
}



#Preview {
    MaintenanceView(user: .mock)
        .environment(CarouselViewModel(user: .mock))
    
}
