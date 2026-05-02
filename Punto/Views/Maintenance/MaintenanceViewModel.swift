//
//  MaintenanceViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import Foundation

@Observable
final class MaintenanceViewModel {
    private let appState: AppState
    var selectedVehicleIndex: Int = 0
    private var vehicles: [Vehicle] {
        appState.user.vehicles
    }
    
    var components: [VehiclePartWrapper] {
        appState.user.vehicles[selectedVehicleIndex].maintenance
    }
    
    var totalVehicleMaintenances: String {
        components.count.description
    }
    
    var currentVehicleRange: String {
        vehicles[self.selectedVehicleIndex].vehicleInformation.mileage.description
    }
    
    init(appState: AppState) {
        self.appState = appState
    }
}

