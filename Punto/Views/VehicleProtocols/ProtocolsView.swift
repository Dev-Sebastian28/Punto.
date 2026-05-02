//
//  VehicleProtocolsView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct ProtocolsView: View {
    @State private var vm : ProtocoslListViewModel
    
    init(appState: AppState) {
        _vm = State(wrappedValue: ProtocoslListViewModel(appState: appState))
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack (alignment: .leading, spacing: 10) {
                
                HeaderComp(
                    title: "Protocols",
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
                    protcolsList
                } else {
                    ContentUnavailableView(
                        "There are no Protocols",
                        systemImage: "Shield",
                        description: Text("Add New protocols.")
                    )
                }
            }.padding(.horizontal, 8)
            NavigationLink {
                ProtocolDetailView(
                    user: .mock,
                    index: vm.selectedVehicleIndex
                )
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "shield")
                        .font(.headline.weight(.bold))
                    Text("Add Protcols")
                        .font(.headline.weight(.semibold))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .foregroundStyle(.white)
                .background(
                    LinearGradient(colors: [.yellow, .orange.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(Capsule())
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 6)
            }.padding()
        }
    }
    
    private var protcolsList: some View {
        // Content
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(vm.protocols.enumerated(),id: \.element.id ) { index ,protocolData in
                
                NavigationLink {
                    ProtocolDetailView(user: .mock, element: protocolData, index: index)
                } label: {
                    ProtocolCardView(VProtocol: protocolData)
                        .padding(2)
                }.buttonStyle(.automatic)
            }
        }
    }
}

#Preview {
    ProtocolsView(appState: AppState())
        .environment(CarouselViewModel(user: .mock))
    
}
