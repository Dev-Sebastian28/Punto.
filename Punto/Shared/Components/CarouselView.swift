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

    private let carouselAnimation: Animation = .spring(response: 0.4, dampingFraction: 0.82)
    
    
    var body: some View {
        VStack(spacing: 0) {
            if isCompresed {
                DominantButtonView(
                    text:  "Show your vehicles" ,
                    color:  color,
                    image: "car.2.fill") {
                    withAnimation(carouselAnimation) {
                        isCompresed.toggle()
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            else {
                Button {
                    withAnimation(carouselAnimation) {
                        isCompresed.toggle()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Hide Section")
                        Image(systemName: "chevron.right")

                    }
                    .foregroundStyle(.gray)
                    .underline()
                }
                .padding(.trailing)
                .transition(.move(edge: .trailing))
            }
            
            if !isCompresed {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .bottom, spacing: 12) {
                            ForEach(Array(vehicles.indices), id: \.self) { index in
                                Button {
                                    withAnimation(carouselAnimation) {
                                        selectedIndex = index
                                        proxy.scrollTo(index, anchor: .center)
                                    }
                                } label: {
                                    CarQuickView(
                                        vehicle: vehicles[index].vehicleInformation,
                                        quickSummary: quickSummary,
                                        selectedColor: color,
                                        isSelected: selectedIndex == index
                                    )
                                    .padding(.vertical, 16)
                                    .scaleEffect(selectedIndex == index ? 1.04 : 0.96)
                                    .offset(y: selectedIndex == index ? -6 : 0)
                                    .opacity(selectedIndex == index ? 1 : 0.82)
                                }
                                .buttonStyle(.plain)
                                .id(index)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .transition(.asymmetric(insertion: .move(edge: .top).combined(with: .opacity), removal: .scale(scale: 0.95).combined(with: .opacity)))
                    .onAppear {
                        proxy.scrollTo(selectedIndex, anchor: .center)
                    }
                    .onChange(of: selectedIndex) { _, newValue in
                        withAnimation(carouselAnimation) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
            }
        }
        .animation(carouselAnimation, value: isCompresed)
        .animation(carouselAnimation, value: selectedIndex)
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
