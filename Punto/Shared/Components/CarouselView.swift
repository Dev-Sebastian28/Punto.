//
//  CarouselView.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//
import SwiftUI

struct CarouselView: View {
    @Binding var selectedIndex: Int
    var vehicles: [Vehicle]
    var titles: [String] = Array(repeating: "", count: 3)
    var numbers: [Int] = Array(repeating: 0, count: 3)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                ForEach(Array(vehicles.indices), id: \.self) { index in
                    Button {
                        selectedIndex = index
                    } label: {
                        CarQuickView(vehicle: vehicles[index].vehicleInformation,
                                     title1: titles[0], value1: numbers[0],
                                     title2: titles[1], value2: numbers[0],
                                     title3: titles[2], value3: numbers[0],
                                     selectedColor: Color.blue,
                                     isSelected: selectedIndex == index)
                        .padding()
                        .scaleEffect(selectedIndex == index ? 1.05 : 1.0)
                    }
                }
            }
        }
    }
    
    private func totalTasks() -> Int {
        vehicles[selectedIndex].tasks.count
    }

    private func totalTodoTasks() -> Int {
        vehicles[selectedIndex].tasks.reduce(0) { partialResult, task in
            task.status == .pending ? partialResult + 1 : partialResult
        }
    }

    private func totalDoneTasks() -> Int {
        vehicles[selectedIndex].tasks.reduce(0) { partialResult, task in
            task.status == .done ? partialResult + 1 : partialResult
        }
    }
}

#Preview {
    CarouselView(
        selectedIndex: .constant(0), vehicles: [
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
        ]
        ,titles: ["Total", "ToDo", "Done"]
    )
}
