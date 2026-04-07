//
//  Card.swift
//  Punto
//
//  Created by Sebastian Garcia on 29/03/26.
//

import SwiftUI

struct FleetVehicleCard: View {
    private(set) var vehicle: Vehicle
    @State var isActive: Bool
    @Environment(NavigationRouter.self) var router


    var body: some View {
        VStack {
            header
            driverCard
            HStack(spacing: 5) {
                QuickInfoButton(title: "Tasks", value: vehicle.tasks.count, image: "checklist", color: .blue) {
                    router.navigate(to: .tasks)
                }

                QuickInfoButton(title: "Protoc.", value: vehicle.protocols.count, image: "shield", color: .brandAmber) {
                    router.navigate(to: .protocols)
                }

                QuickInfoButton(title: "Manten.", value: vehicle.maintenance.count, image: "wrench.fill", color: .brandBlueDark) {
                    router.navigate(to: .manteinances)
                }

                QuickInfoButton(title: "Expens.", value: vehicle.expenses.count, image: "dollarsign", color: .brandGreen) {
                    router.navigate(to: .expenses)
                }
            }
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.accentColor.opacity(0.2))
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.cardStroke, lineWidth: 1)
                }
        }
    }
    private var header: some View {
        Image(vehicle.vehicleInformation.image)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .bottomLeading) {
                VStack (alignment: .leading) {
                    HStack {
                        Spacer()
                        Text(isActive ? "Active" : "Inactive")
                            .font(.title3)
                            .foregroundStyle(isActive ? Color.white : Color.black).bold()
                            .padding(.horizontal, 13)
                            .padding(.vertical, 5)
                            .background(isActive ? Color.brandGreen : Color.platformGray6)
                            .clipShape(.capsule)
                    }
                    
                    Spacer()
                    
                    Text("\(vehicle.vehicleInformation.brand)" + " " + "\(vehicle.vehicleInformation.model)")
                        .font(.title2.bold())
                    HStack {
                        Text("La blanca")
                        Text("-")
                        Text("\(vehicle.vehicleInformation.plate)")
                    }
                }
                .foregroundStyle(.white)
                .padding(.horizontal,8)
                .padding(.vertical, 6)
            }
    }
    private var driverCard: some View {
        HStack {
            HStack {
                Text("SG")
                    .foregroundStyle(.white).bold()
                    .padding(10)
                    .background(Color.brandBlue)
                    .clipShape(.circle)
                
                VStack (alignment: .leading) {
                    Text("Driver")
                        .foregroundStyle(Color.textMuted)
                    Text("Santiago Garcia")
                        .bold()
                        .foregroundStyle(Color.brandBlueDark)
                }
                Spacer()
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 6)
            .background(Color.surfacePrimary.opacity(0.92))
            
            VStack {
                HStack (spacing: 0) {
                    Image(systemName: "person.3.fill")
                        .font(.title3)
                    Image(systemName: "plus")
                }
                Text("Add New")
                
            }
            .padding(.trailing)
            .bold()
            .foregroundStyle(.white)
            .padding(6)
        }
        .background(
            LinearGradient(
                colors: [.brandGreen, .brandGreenDark],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

private struct QuickInfoButton: View {
    var title: String
    var value: Int
    var image: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button  {
            action()
            
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: image)
                        .foregroundStyle(color)
                    
                    Text("\(value)")
                        .font(.title3)
                        .bold()
                }
                
                Text(title)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .stroke(color.opacity(0.7), lineWidth: 1)
            }
        }.foregroundStyle(.black)
    }
}

#Preview {
    FleetVehicleCard(vehicle: TransportationVehicle(vehicleInformation: .init(id: .init(), image: "volvo", plate: "DMW-234", brand: "Volvo", model: "X900x", year: 2020, mileage: 100000, engine: "V8", transmission: .automatic, fuel: .diesel)), isActive: true)
        .environment(NavigationRouter())
}
