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
    var selectedVehicleIndex: Int = 0
    private var vehicles: [Vehicle] {
        user.vehicles
    }
    
    var components: [VehiclePartWrapper] {
        user.vehicles[selectedVehicleIndex].maintenance
    }
    
    var totalVehicleMaintenances: String {
        components.count.description
    }
    
    var currentVehicleRange: String {
        vehicles[self.selectedVehicleIndex].vehicleInformation.mileage.description
    }
    
    init(user: User) {
        self.user = user
    }
}

