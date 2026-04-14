//
//  AddVehicleView.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/02/26.
//

import SwiftUI

struct AddVehicleView: View {
    @State private var isAddVehiclePresented: Bool = false
    @State var userExample: User = .init(name: "", email: "", access: .admin, country: .argentina)
    @Environment(NavigationRouter.self) var router
    

    var body: some View {
        ZStack {
            VStack {
                
                header
                
                // vehicles Scroll View
                ScrollView(.vertical, showsIndicators: false) {
                    
                    ForEach(userExample.vehicles, id: \.vehicleInformation.id) { vehicle in
                        VehicleInformationView(vehicle: vehicle)
                            .padding(4)
                    }
                }
                
                
                DButtonComp(text: "Add Vehicle", color: .blue, image: "plus") {
                    isAddVehiclePresented.toggle()
                    
                }.sheet(isPresented: $isAddVehiclePresented) {
                    AddVehicleForm(isAddVehiclePresented: $isAddVehiclePresented)
                }
            }
            .padding(.horizontal, 10)
        }
    }
    
    var header: some View {
        // Header
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Welcome to Punto")
                    .font(.system(.title, design: .default))
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                LaterButton
                
            }
            
            Text("Add your vehicles here and connect them to your drivers")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    @ViewBuilder
    private var LaterButton: some View {
            Button {
                router.showMainTabs()
            } label: {
                VStack {
                    Text("Add Later")
                        .font(.system(size: 15).weight(.semibold))
                        .foregroundStyle(.gray)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(Color.gray.opacity(0.15))
                        )
                }
            }
    }
}





#Preview {
    AddVehicleView()
        .environment(NavigationRouter())
}
