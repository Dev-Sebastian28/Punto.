//
//  AddVehicleViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/04/26.
//
import Foundation

@Observable
final class AddVehicleViewModel {
    private(set) var user: User
    let vehicleRepository = VehicleRepository()
    
    var hasVehicle: Bool {
        !user.vehicles.isEmpty
    }
    var vehicles: [Vehicle] {
        user.vehicles
    }
    var vehicleCount: String {
        user.vehicles.count.description
    }
    
    func addVehicle(_ vehicle: Vehicle) {
        user.vehicles.append(vehicle)
        Task {
            try? await vehicleRepository.createVehicle(info: vehicle.vehicleInformation)

        }
    }
    
    init(user: User) {
        self.user = user
    }
}
