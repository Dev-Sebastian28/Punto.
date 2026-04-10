//
//  MaintenanceView.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/03/26.
//

import SwiftUI

struct MaintenanceView: View {
    let title = "Maintenances"
    let description = "Welcome to the maintenance section, here you monitor your maintenances and add new ones"
    let algorithm = MaintenanceCarrouselAlgorithm()
    @State var vm: MaintenanceViewModel = .init()
    @State var selectedVehicle: Int = 0
    @State var isHide: Bool = false
    
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                
                Header(title: title , image: "wrench.and.screwdriver.fill", description: description , color: .blue, gradient: .none)
                
                CarouselView(algorithm: MaintenanceCarrouselAlgorithm(), color: .blue, selectedIndex: $selectedVehicle)
                                
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
    MaintenanceView()
        .environment(CarouselViewModel(user: .init(name: "Sebastian", email: "sebas@example.com", access: .admin, country: .colombia)))

}
