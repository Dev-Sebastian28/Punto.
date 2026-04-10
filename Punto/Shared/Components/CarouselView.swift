//
//  CarouselView.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//
import SwiftUI

struct CarouselView: View {
    let algorithm: CarrouselAlgorithm
    let color: Color
    private let carouselAnimation: Animation = .spring(response: 0.4, dampingFraction: 0.82)
    @Binding var selectedIndex: Int
    @Environment(CarouselViewModel.self) var vm
    
    
    var body: some View {
        VStack(spacing: 0) {
            if vm.isCarousellHide {
                DominantButtonView(
                    text: "Show your vehicles",
                    color: color,
                    image: "car.2.fill"
                ) {
                    withAnimation(carouselAnimation) {
                        vm.isCarousellHide.toggle()
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            if !vm.isCarousellHide {
                ScrollViewReader { proxy in
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            
                            ForEach(Array(vm.vehicles.enumerated()), id: \.element.vehicleInformation.id) { index, vehicle in
                                
                                Button {
                                    withAnimation(carouselAnimation) {
                                        selectedIndex = index
                                        proxy.scrollTo(index, anchor: .center)
                                    }
                                } label: {
                                    VehicleQuickView(
                                        vehicle: vehicle.vehicleInformation,
                                        quickSummary: algorithm.perform(vehicle: vehicle),
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
                    
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .top).combined(with: .opacity),
                            removal: .scale(scale: 0.95).combined(with: .opacity)
                        )
                    )
                    
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
            
            Separator()
        }
        .animation(carouselAnimation, value: vm.isCarousellHide)
        .animation(carouselAnimation, value: selectedIndex)
        .environment(vm)
    }
}

@Observable
class CarouselViewModel {
    private(set) var user: User
    var vehicles: [Vehicle] { user.vehicles }
    
    var isCarousellHide: Bool
    
    init(user: User) {
        self.user = user
        self.isCarousellHide = false
    }
}

#Preview {
    CarouselView(algorithm: TasklAlgorithm(), color: .blue, selectedIndex: .constant(0))
}



