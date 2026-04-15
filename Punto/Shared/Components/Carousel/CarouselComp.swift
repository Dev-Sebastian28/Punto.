//
//  CarouselView.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//
import SwiftUI

struct CarouselComp: View {
    let strategy: CarouselStrategy
    let color: Color
    @Binding var selectedIndex: Int
    @Environment(CarouselViewModel.self) var vm
    
    
    var body: some View {
        VStack(spacing: -6) {
            
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
                                        quickSummary: vm.summaries(for: vehicle, algorithm: strategy),
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
                }.animation(.linear, value: vm.isCarousellHide)
                Divider()

            }
        }
        .animation(carouselAnimation, value: vm.isCarousellHide)
        .animation(carouselAnimation, value: selectedIndex)
        .environment(vm)
    }
    private var carouselAnimation: Animation {
        .spring(response: 0.4, dampingFraction: 0.82)
    }
}


#Preview {
    CarouselComp(strategy: TaskAlgorithm(), color: .red, selectedIndex: .constant(0))
        .environment(CarouselViewModel(user: .mock))
}



