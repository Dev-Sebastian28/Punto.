//
//  VehicleProtocolsView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct VehicleProtocolsView: View {
    @State private var vm = VehicleProtocoslViewModel(user: .init(name: "", email: "", access: .admin, country: .argentina))
    @State private var isHidden: Bool = false
    @Environment(NavigationRouter.self) var router

    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            
            Header(title: "Protocols", image: "shield.fill", description: "Welcome to the Protocols section, here you can see the protocols that your vehicles have to follow.", color: .yellow, gradient: .none)
            
            CarouselView(algorithm: ProtocolsAlgorithm(), color: .yellow, selectedIndex: $vm.selectedVehicle)
            selectedVehicleInfo
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(vm.protocols,id: \.id ) { protocolData in
                        ProtocolCardView(vehicleProtocol: protocolData)
                        .padding(2)
                    }
            
            }
            
            DominantButtonView(text: "Add Protocol", color: .yellow, image: "shield") {
                router.navigate(to: .addprotocols)
            }
        }
        .padding(.horizontal)
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
    VehicleProtocolsView()
        .environment(NavigationRouter())
        .environment(CarouselViewModel(user: .init(name: "Sebastian", email: "sebas@example.com", access: .admin, country: .colombia)))

}
