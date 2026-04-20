//
//  VehicleProtocolsView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct ProtocolsView: View {
    @State private var vm : ProtocoslListViewModel
    var user: User
    init(user: User) {
        _vm = State(wrappedValue: ProtocoslListViewModel(user: user))
        self.user = user
        print(user.id)

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
                    SelectedInfoComp(
                        model: vm.selectedModelBrand,
                        plate: vm.selectedPlate,
                        total: vm.protocolsCount
                    )
                    
                    if vm.areProtocols {
                        // Content
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(vm.protocols.enumerated(),id: \.element.id ) { index ,protocolData in
                                
                                NavigationLink {
                                    ProtocolDetailView(user: user, element: protocolData, index: index)
                                } label: {
                                    ProtocolCardView(protocolM: protocolData)
                                        .padding(2)
                                }.buttonStyle(.automatic)
                            }
                        }
                    } else {
                        ContentUnavailableView(
                            "There are no Protocols",
                            systemImage: "Shield",
                            description: Text("Add New protocols.")
                        )
                    }
                    
                    NavigationLink {
                       
                        ProtocolDetailView(user: user, index: vm.selectedVehicleIndex)
                        
                    } label: {
                        HStack {
                            Text("Add Protocol")
                            Image(systemName: "plus")
                        }
                        .foregroundStyle(.white).bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(
                            Color.yellow
                                .cornerRadius(10)
                        )
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
}

#Preview {
    ProtocolsView(user: .mock)
        .environment(NavigationRouter())
        .environment(CarouselViewModel(user: .mock))
    
}
