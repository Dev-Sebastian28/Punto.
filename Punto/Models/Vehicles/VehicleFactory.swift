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
    var maintenance: [MaintainableComponent] { get set }
    var tasks: [Task] { get set }
    var protocols: [VehicleProtocol] { get set }
    var expenses: [Expense] { get set }
    var vehicleInformation: VehicleInformation { get set }
    var isActive: Bool { get set }

}

// First Concrete Product: mulas - camiones - pickUps
class TransportationVehicle: Vehicle {
    
    var id: UUID = UUID()
    var maintenance: [MaintainableComponent] = []
    var expenses: [Expense] = [.init(name: "warranty", description: "it is a warranty", amount: -200, date: .distantPast, type: "")]
    var tasks: [Task] = []
    var protocols: [VehicleProtocol] = [.init(
        id: UUID(),
        name: "Revisión Preoperacional PESV",
        description: "Inspección técnica obligatoria según normatividad colombiana antes de iniciar ruta.",
        tasks: [
            ProtocolTask(id: UUID(), taskName: "Nivel de aceite y refrigerante", description: "Verificar que los fluidos estén en los niveles óptimos.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Estado de llantas (Labrado)", description: "Revisar que el desgaste no supere los límites legales.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Kit de carretera completo", description: "Extintor vigente, tacos, gata y señales reflectivas.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Luces y direccionales", description: "Comprobar funcionamiento de luces altas, bajas y frenado.", isCompleted: false, isActive: true)
        ],
        importance: .high,
        time: .startingWork
    ), .init(
        id: UUID(),
        name: "Revisión Preoperacional PESV",
        description: "Inspección técnica obligatoria según normatividad colombiana antes de iniciar ruta.",
        tasks: [
            ProtocolTask(id: UUID(), taskName: "Nivel de aceite y refrigerante", description: "Verificar que los fluidos estén en los niveles óptimos.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Estado de llantas (Labrado)", description: "Revisar que el desgaste no supere los límites legales.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Kit de carretera completo", description: "Extintor vigente, tacos, gata y señales reflectivas.", isCompleted: false, isActive: true),
            ProtocolTask(id: UUID(), taskName: "Luces y direccionales", description: "Comprobar funcionamiento de luces altas, bajas y frenado.", isCompleted: false, isActive: true)
        ],
        importance: .high,
        time: .startingWork
    )]
    var vehicleInformation: VehicleInformation
    var cargoInfo: CargoInfo?
    var isActive: Bool = false

    init(vehicleInformation: VehicleInformation) {
        self.vehicleInformation = vehicleInformation
    }
}

// Second Concrete Product: vehiculos de trasporte privado: uber - didi, etc
class PrivateVehicle: Vehicle {

    var id: UUID = UUID()
    var maintenance: [MaintainableComponent] = []
    var expenses: [Expense] = []
    var tasks: [Task] = []
    var protocols: [VehicleProtocol] = []
    var vehicleInformation: VehicleInformation
    var isActive: Bool = false

    init(vehicleInformation: VehicleInformation) {
        self.vehicleInformation = vehicleInformation
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
