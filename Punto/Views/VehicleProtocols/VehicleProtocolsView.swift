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
            
            HeaderComp(title: "Protocols",
                   image: "shield.fill",
                   description: "Welcome to the Protocols section, here you can see the protocols that your vehicles have to follow.",
                   color: .yellow,
                   gradient: .none
            )
            
            CarouselComp(
                strategy: ProtocolsAlgorithm(), color: .yellow,
                selectedIndex: $vm.selectedVehicle
            )
            
            selectedVehicleInfo
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(vm.protocols,id: \.id ) { protocolData in
                        ProtocolCardView(vehicleProtocol: protocolData)
                        .padding(2)
                    }
            
            }
            
            DButtonComp(text: "Add Protocol", color: .yellow, image: "shield") {
                router.navigate(to: .addprotocols)
            }
        }.padding(.horizontal)
        
    }
    
    
    private var selectedVehicleInfo: some View {
        VStack(alignment: .leading) {
            
            Text(vm.quickInfo.brand + (vm.quickInfo.model))
                .font(.title.bold())
            
            HStack {
                Text(vm.quickInfo.plate)
                
                Spacer()
                
                Text("Total: " + "\(vm.protocolCount)" )
            }.foregroundStyle(.secondary)
        }
    }
}

#Preview {
    VehicleProtocolsView(user: .mock)
        .environment(NavigationRouter())
        .environment(CarouselViewModel(user: .mock))

}
