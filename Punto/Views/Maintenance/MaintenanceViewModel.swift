//
//  MaintenanceViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import Foundation

@Observable
final class MaintenanceViewModel {
    private let user: User
    var selectedVehicle: Int = 0
    var vehicles: [Vehicle] {
        user.vehicles
    }
    
    var components: [VehiclePartWrapper] {
        user.vehicles[selectedVehicle].maintenance
    }
    
    var totalMaintenances: String {
        components.count.description
    }
    
    var currentRange: String {
        vehicles[self.selectedVehicle].vehicleInformation.mileage.description
    }
    
    init(user: User) {
        self.user = user
    }
}

