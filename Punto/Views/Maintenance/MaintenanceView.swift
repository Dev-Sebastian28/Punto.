//
//  MaintenanceView.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/03/26.
//

import SwiftUI

struct MaintenanceView: View {
    @State var vm: MaintenanceViewModel = .init()
    @State var selectedVehicle: Int = 0
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                
                // Header
                titleHeader
                
                // Carrusel
                CarouselView(selectedIndex: $selectedVehicle, vehicles: vm.vehicles, titles: ["Urgency","Warning","Well"], numbers: [0,0,0], color: .blue)
                
                Separator()
                
                MaintenanceFilterView(vm: vm)
                
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(vm.vehicles[selectedVehicle].maintenance, id: \.componentName) { part in
                            MaintenanceCard(maintainablePart: part)
                                .padding(.top, 5)
                                .padding(.horizontal, 5)
                        }
                    }
            }.padding(.horizontal, 5)
        }
        
        Button {
            // Acción
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Add Part")
            }
            .font(.title2.bold())
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 19)
            .background(Color.blue.opacity(0.78).gradient)
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
    }
    
    @ViewBuilder
    var titleHeader: some View {
        Text("Maintenance")
            .font(.system(.largeTitle, design: .default))
            .fontWeight(.bold)
            .foregroundColor(.blue)
        
        Text("Select a vehicle to see and add its maintainable parts")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}



#Preview {
    MaintenanceView(selectedVehicle: 0)
}
