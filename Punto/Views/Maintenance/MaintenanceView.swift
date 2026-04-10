//
//  MaintenanceView.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/03/26.
//

import SwiftUI

struct MaintenanceView: View {
    
    let algorithm = MaintenanceCarrouselAlgorithm()
    @State var vm: MaintenanceViewModel = .init()
    @State var selectedVehicle: Int = 0
    var quickSummary: [QuickSummary2]
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                
                Header(title: "Maintenances", image: "wrench.and.screwdriver.fill", description: "Welcome to the maintenance section, here you monitor your maintenances and add new ones", color: .blue, gradient: .none)
                
                CarouselView(algorithm: MaintenanceCarrouselAlgorithm(), color: .blue, selectedIndex: $selectedVehicle, vehicles: vm.vehicles)
                                
                MaintenanceFilterView(vm: vm)
                
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(vm.vehicles[selectedVehicle].maintenance, id: \.componentName) { part in
                            MaintenanceCard(maintainablePart: part)
                                .padding(.top, 5)
                                .padding(.horizontal, 5)
                        }
                    }
            }.padding(.horizontal, 8)
        }
        
        DominantButtonView(text: "Add Component", color: .blue, image: "plus") {
            
        }
    }
}



#Preview {
    MaintenanceView(quickSummary: [
        .init(title: "Critical", value: 0, color: .red),
        .init(title: "Warning", value: 0, color: .yellow),
        .init(title: "Well", value: 0, color: .green)
    ])
}
