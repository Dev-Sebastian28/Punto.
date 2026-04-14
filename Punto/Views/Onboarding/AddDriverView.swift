//
//  AddDriverView.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/04/26.
//

import SwiftUI

struct AddDriverView: View {
    @State private var isAddDriverPresented: Bool = false
    @State var userExample: User = .init(name: "", email: "", access: .admin, country: .argentina)
    @Environment(NavigationRouter.self) var router

    var body: some View {
        VStack {
            header
            
            ScrollView(.vertical, showsIndicators: false) {
                
                ForEach(userExample.vehicles, id: \.vehicleInformation.id) { vehicle in
                    VehicleInformationView(vehicle: vehicle, isIndriverView: true)
                        .padding(4)
                }
            DriverCardView(driverName: "Sebastian Garcia", driverNumber: "ADW", driverMail: "")
            }
            
            DButtonComp(text: "Add Driver", color: .green, image: "plus") {
                isAddDriverPresented.toggle()
            }.sheet(isPresented: $isAddDriverPresented) {
                AddDriverForm(index: 0, isPresented: $isAddDriverPresented)
                    .presentationDetents([.fraction(0.4)])
            }
            
        }.padding(.horizontal, 11)
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Icono con estilo de aplicación moderna
            HStack {
                Text("Add Driver")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                
                
                Image(systemName: "person.badge.plus")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.green)
                
                Spacer()
                
                LaterButton
                
            }
            
            // Textos principales
            VStack(alignment: .leading, spacing: 4) {
                
                
                Text("Invite a new driver to your fleet to start managing their tasks and performance.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
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
    AddDriverView()
        .environment(NavigationRouter())
}
