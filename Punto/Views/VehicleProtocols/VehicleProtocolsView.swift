//
//  VehicleProtocolsView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/03/26.
//

import SwiftUI

struct VehicleProtocolsView: View {
    @State var selectedVehicle: Int
    @State private var isPresentedAddProtocol: Bool = false
    @State var userExample: User = .init(name: "", email: "", access: .admin, country: .argentina)
    let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    var body: some View {
        VStack (spacing: 0){

            // Header
            VStack(alignment: .leading, spacing: 0) {
                Text("Protocols")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)

                Text("Select a vehicle to add its protocols")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()


            // Quick View
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button {} label: {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray,lineWidth: 1)
                            .frame(width: 110, height: 160)
                            .overlay(alignment: .center) {
                                VStack {
                                    Image(systemName: "car")
                                    Text("All Vehicles")
                                }
                            }
                    }

                    ForEach(userExample.vehicles.enumerated().map({ $0 }), id: \.element.vehicleInformation.id) { index, vehicle in
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedVehicle = index
                            }
                        } label: {
                            CarQuickView(vehicle: vehicle.vehicleInformation, title1: "Total", value1: 1, title2: "ToDo", value2: userExample.vehicles[index].tasks.count, title3: "Done", value3: 4, selectedColor: Color.yellow, isSelected: selectedVehicle == index)
                                .padding()
                                .scaleEffect(selectedVehicle == index ? 1.05 : 1.0)
                        }
                    }

                }
            }

            // Separator
            Rectangle()
                .frame(width: 380, height: 1)
                .foregroundStyle(.gray)
                .padding(.vertical, 10)

            // Vehicle Selected Header

            VStack {
                HStack {
                    Text(userExample.vehicles[selectedVehicle].vehicleInformation.brand)
                    Text(userExample.vehicles[selectedVehicle].vehicleInformation.model)
                    Spacer()
                }.font(.title.bold())
                HStack {
                    Text(userExample.vehicles[selectedVehicle].vehicleInformation.plate)
                    Spacer()
                    Text("\(userExample.vehicles[selectedVehicle].protocols.count) Total")
                }
            }.padding(.horizontal, 10)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(userExample.vehicles[selectedVehicle].protocols,id: \.id ) { protocolData in
                        VehicleProtocolCardView(vehicleProtocol: protocolData)
                    }
                }
            }


            // Button
            Button(action: {
                // Acción al presionar el botón
                print("Botón presionado")
            }) {
                HStack(spacing: 12) { // HStack para texto e icono
                    Text("Add Protocol")
                        .font(.system(size: 18, weight: .bold)) // Fuente y peso similares a la imagen
                        .foregroundColor(.white)

                    Image(systemName: "checkmark.shield") // Icono SF Symbol de escudo con checkmark
                        .font(.system(size: 20, weight: .semibold)) // Tamaño y peso del icono
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20) // Padding horizontal interno
                .padding(.vertical, 12)   // Padding vertical interno
                .background(Color(red: 247/255, green: 216/255, blue: 66/255)) // Color de fondo amarillo aproximado
                .cornerRadius(15) // Esquinas redondeadas
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear{
            userExample.vehicles[selectedVehicle].protocols.addProtocol(vehicleProtocol: .init(
                id: UUID(),
                name: "Revisión Preoperacional PESV",
                description: "Inspección técnica obligatoria según normatividad colombiana antes de iniciar ruta.",
                tasks: [
                    ProtocolTask(id: UUID(), task: "Nivel de aceite y refrigerante", description: "Verificar que los fluidos estén en los niveles óptimos.", isCompleted: false, isActive: true),
                    ProtocolTask(id: UUID(), task: "Estado de llantas (Labrado)", description: "Revisar que el desgaste no supere los límites legales.", isCompleted: false, isActive: true),
                    ProtocolTask(id: UUID(), task: "Kit de carretera completo", description: "Extintor vigente, tacos, gata y señales reflectivas.", isCompleted: false, isActive: true),
                    ProtocolTask(id: UUID(), task: "Luces y direccionales", description: "Comprobar funcionamiento de luces altas, bajas y frenado.", isCompleted: false, isActive: true)
                ],
                importance: .high,
                time: .startingWork
            ))

            userExample.vehicles[selectedVehicle].protocols.addProtocol(vehicleProtocol: .init(
                id: UUID(),
                name: "Revisión Preoperacional PESV",
                description: "Inspección técnica obligatoria según normatividad colombiana antes de iniciar ruta.",
                tasks: [
                    ProtocolTask(id: UUID(), task: "Nivel de aceite y refrigerante", description: "Verificar que los fluidos estén en los niveles óptimos.", isCompleted: false, isActive: true),
                    ProtocolTask(id: UUID(), task: "Estado de llantas (Labrado)", description: "Revisar que el desgaste no supere los límites legales.", isCompleted: false, isActive: true),
                    ProtocolTask(id: UUID(), task: "Kit de carretera completo", description: "Extintor vigente, tacos, gata y señales reflectivas.", isCompleted: false, isActive: true),
                    ProtocolTask(id: UUID(), task: "Luces y direccionales", description: "Comprobar funcionamiento de luces altas, bajas y frenado.", isCompleted: false, isActive: true)
                ],
                importance: .high,
                time: .startingWork
            ))
        }
    }
}

#Preview {
    VehicleProtocolsView(selectedVehicle: 0)
}
