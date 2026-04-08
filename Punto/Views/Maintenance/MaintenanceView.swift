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
    var quickSummary: [QuickSummary2]
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                
                titleHeader
                
                CarouselView(selectedIndex: $selectedVehicle, quickSummary: quickSummary, vehicles: vm.vehicles, color: .blue)
                
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
        
        DominantButtonView(text: "Add Component", color: .blue, image: "plus") {
            
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
    MaintenanceView(quickSummary: [
        .init(title: "Critical", value: 0, color: .red),
        .init(title: "Warning", value: 0, color: .yellow),
        .init(title: "Well", value: 0, color: .green)
    ])
}
