//
//  MaintenanceView.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/03/26.
//

import SwiftUI

struct MaintenanceView: View {
    @State private var vm: MaintenanceViewModel
    @State var selectedVehicle: Int = 0
    
    init(user: User) {
        _vm = State(wrappedValue: MaintenanceViewModel(user: user))
    }
    
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                
                Header(
                    title: "" ,
                       image: "wrench.and.screwdriver.fill",
                       description: "" ,
                       color: .blue,
                       gradient: .none
                )
                
                CarouselView(
                    algorithm: MaintenanceCarrouselAlgorithm(), color: .blue,
                    selectedIndex: $selectedVehicle
                )
                                
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
    MaintenanceView(user: .mock)
        .environment(CarouselViewModel(user: .mock))

}
