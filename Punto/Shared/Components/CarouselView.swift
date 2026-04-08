//
//  CarouselView.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//
import SwiftUI

struct CarouselView: View {
    @Binding var selectedIndex: Int
    @State private var isCompresed = false
    var quickSummary: [QuickSummary2]
    var vehicles: [Vehicle]
    var color: Color
    
    
    var body: some View {
                
        VStack {
            if !isCompresed {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom) {
                        ForEach(Array(vehicles.indices), id: \.self) { index in
                            Button {
                                selectedIndex = index
                            } label: {
                                CarQuickView(vehicle: vehicles[index].vehicleInformation, quickSummary: quickSummary,
                                             selectedColor: color,
                                             isSelected: selectedIndex == index)
                                .padding()
                                .scaleEffect(selectedIndex == index ? 1.05 : 1.0)
                            }.buttonStyle(.plain)
                        }
                    }
                }
            }

            DominantButtonView(text: "Show your vehicles", color: .myBlue, image: "car.2.fill") {
                isCompresed.toggle()
            }.padding(.horizontal)
        }
    }
}

#Preview {
    CarouselView(
        selectedIndex: .constant(0), quickSummary: [.init(title: "Done", value: 0, color: .brandAmber), .init(title: "Done", value: 0, color: .brandAmber), .init(title: "Done", value: 0, color: .brandAmber),], vehicles: [
            TransportationVehicle(
                vehicleInformation: .init(
                    id: UUID(),
                    image: "volvo",
                    plate: "DMW-2342",
                    brand: "Volvo",
                    model: "X900x",
                    year: 2020,
                    mileage: 20000,
                    engine: "V8",
                    transmission: .automatic,
                    fuel: .diesel
                )
            ),
            TransportationVehicle(
                vehicleInformation: .init(
                    id: UUID(),
                    image: "volvo",
                    plate: "DMW-2342",
                    brand: "Volvo",
                    model: "X900x",
                    year: 2020,
                    mileage: 20000,
                    engine: "V8",
                    transmission: .automatic,
                    fuel: .diesel
                )
            )
        ], color: .red
    )
}
