//
//  VehicleFactory.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/02/26.
//

import Foundation

// I used this pattern because for now we have various option of vehicle such as transport vehicle who has an special property cargoInfo and private vehicle who do not have cargoInfo, as the app grows there may be other type of vehicles, and by using this pattern I only need to add new vehicle but not change the factory. I did not use abstractFactory because there are many variants of vehicles but they are to related.


// Product Interface
protocol Vehicle {
    var maintenance: [VehiclePartWrapper] { get set }
    var tasks: [Task] { get set }
    var protocols: [VehicleProtocol] { get set }
    var expenses: [Expense] { get set }
    var vehicleInformation: VehicleInformation { get set }
    var isActive: Bool { get set }

}

// First Concrete Product: mulas - camiones - pickUps
class TransportationVehicle: Vehicle {
    
    var id: UUID = UUID()
    var maintenance: [VehiclePartWrapper]
    var expenses: [Expense]
    var tasks: [Task]
    var protocols: [VehicleProtocol]
    var vehicleInformation: VehicleInformation
    var cargoInfo: CargoInfo?
    var isActive: Bool = false
    
    init(
        id: UUID = UUID(),
        maintenance: [VehiclePartWrapper] = [],
        expenses: [Expense] = [],
        tasks: [Task] = [],
        protocols: [VehicleProtocol] = [],
        vehicleInformation: VehicleInformation,
        isActive: Bool = false
    ) {
        self.id = id
        self.vehicleInformation = vehicleInformation
        self.isActive = isActive
        
        // Llamadas aleatorias usando las extensiones corregidas
        self.maintenance = Array([VehiclePartWrapper].dummyData().shuffled().prefix(Int.random(in: 2...5)))
        self.expenses = Array([Expense].dummyData().shuffled().prefix(Int.random(in: 3...6)))
        self.tasks = Array([Task].dummyData().shuffled().prefix(Int.random(in: 3...6)))
        self.protocols = Array([VehicleProtocol].dummyData().shuffled().prefix(2))
    }
}

// Second Concrete Product: vehiculos de trasporte privado: uber - didi, etc
class PrivateVehicle: Vehicle {
    var id: UUID = UUID()
    var maintenance: [VehiclePartWrapper]
    var expenses: [Expense]
    var tasks: [Task]
    var protocols: [VehicleProtocol]
    var vehicleInformation: VehicleInformation
    var isActive: Bool = false
    
    init(
        id: UUID = UUID(),
        maintenance: [VehiclePartWrapper] = [],
        expenses: [Expense] = [],
        tasks: [Task] = [],
        protocols: [VehicleProtocol] = [],
        vehicleInformation: VehicleInformation,
        isActive: Bool = false
    ) {
        self.id = id
        self.vehicleInformation = vehicleInformation
        self.isActive = isActive
        
        // Llamadas aleatorias usando las extensiones corregidas
        self.maintenance = Array([VehiclePartWrapper].dummyData().shuffled().prefix(Int.random(in: 3...6)))
        self.expenses = Array([Expense].dummyData().shuffled().prefix(Int.random(in: 3...6)))
        self.tasks = Array([Task].dummyData().shuffled().prefix(3))
        self.protocols = Array([VehicleProtocol].dummyData().shuffled().prefix(2))
    }
}

// Factory
struct VehicleFactory {
    func createVehicle(type: VehicleType) -> Vehicle {
        switch type {
            
        case .transportVehicle:
            return TransportationVehicle(vehicleInformation: .init(image: "", plate: "", brand: "", model: "", year: 0, mileage: 0, engine: "", transmission: .automatic, fuel: .diesel))
            
        case .privateVehicle:
            return PrivateVehicle(vehicleInformation: .init(image: "", plate: "", brand: "", model: "", year: 0, mileage: 0, engine: "", transmission: .automatic, fuel: .diesel))
        }
    }
}

// Enum For Type of vehicle
enum VehicleType {
    case transportVehicle
    case privateVehicle
}

