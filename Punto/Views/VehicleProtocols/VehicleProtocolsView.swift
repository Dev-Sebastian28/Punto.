//
//  VehicleProtocolsView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct VehicleProtocolsView: View {
    @State private var vm = VehicleProtocoslViewModel(user: .init(name: "", email: "", access: .admin, country: .argentina))
    var quickSummary: [QuickSummary2]
    @Environment(NavigationRouter.self) var router

    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            
            header
            CarouselView(algorithm: ProtocolsAlgorithm(), color: .yellow, selectedIndex: $vm.selectedVehicle, vehicles: vm.vehicles)
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
    
    private var header: some View {
 
        VStack(alignment: .leading ,spacing: 0) {
            Text("Protocols")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
            
            Text("Select a vehicle to add its protocols")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        
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
    VehicleProtocolsView(quickSummary: [
        .init(title: "Critical", value: 0, color: .red),
        .init(title: "Warning", value: 0, color: .yellow),
        .init(title: "Well", value: 0, color: .green)
    ])
        .environment(NavigationRouter())
}
