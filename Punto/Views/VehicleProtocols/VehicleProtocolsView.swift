//
//  VehicleProtocolsView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct VehicleProtocolsView: View {
    @State private var vm : VehicleProtocoslViewModel
    @Environment(NavigationRouter.self) var router
    
    init(user: User) {
        _vm = State(wrappedValue: VehicleProtocoslViewModel(user: user))
    }

    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            
            if vm.areVehicles {
                
                HeaderComp(title: "Protocols",
                       image: "shield.fill",
                       description: "Welcome to the Protocols section, here you can see the protocols that your vehicles have to follow.",
                       color: .yellow,
                       gradient: .none
                )
                
                CarouselComp(
                    strategy: ProtocolsAlgorithm(),
                    color: .yellow,
                    selectedIndex: $vm.selectedVehicleIndex
                )
                selectedVehicleInfo
                
                // Content
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(vm.protocols,id: \.id ) { protocolData in
                            ProtocolCardView(vehicleProtocol: protocolData)
                            .padding(2)
                        }
                
                }
                
                DButtonComp(text: "Add Protocol", color: .yellow, image: "shield") {
                    router.navigate(to: .addprotocols)
                }
                
            } else {
                ContentUnavailableView(
                    "There are no vehicles",
                    systemImage: "car.fill",
                    description: Text("Add a vehicle to see their protocols.")
                )
            }
        }.padding(.horizontal, 8)
    }
    
    
    private var selectedVehicleInfo: some View {
        VStack(alignment: .leading) {
            
            Text(vm.selectedModelBrand)
                .font(.title.bold())
            
            HStack {
                Text(vm.selectedPlate)
                
                Spacer()
                
                Text("Total: " + "\(vm.protocolsCount)" )
            }.foregroundStyle(.secondary)
        }
    }
}

#Preview {
    VehicleProtocolsView(user: .mock)
        .environment(NavigationRouter())
        .environment(CarouselViewModel(user: .mock))

}
