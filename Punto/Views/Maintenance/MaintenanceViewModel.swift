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
    
    var vehicles: [Vehicle] {user.vehicles}
    
    var maintainableComponents: [MaintainableComponent] {user.vehicles[selectedVehicle].maintenance}
    
    var totalMaintenances: Int { maintainableComponents.count }

    var currentRange: Int {vehicles[self.selectedVehicle].vehicleInformation.mileage}
    
    init(user: User) {
        self.user = user
    }
}
