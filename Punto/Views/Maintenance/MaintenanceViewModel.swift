//
//  MaintenanceViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import Foundation

@Observable
final class MaintenanceViewModel {
    var userModel: User
    var selectedVehicle: Int = 0
    
    var vehicles: [Vehicle] {userModel.vehicles}
    
    var maintainableComponents: [MaintainableComponent] {userModel.vehicles[selectedVehicle].maintenance}
    
    var totalMaintenances: Int { maintainableComponents.count }

    var currentRange: Int {vehicles[self.selectedVehicle].vehicleInformation.mileage}
    
    init(userModel: User = User(name: "", email: "", access: .user, country: .argentina)) {
        self.userModel = userModel
        randomDummyData()
        randomDummyData()
        randomDummyData()
    }
}

extension MaintenanceViewModel {
    func randomDummyData() {
        guard !userModel.vehicles.isEmpty else { return }
        let randomIndex = Int.random(in: 0..<userModel.vehicles.count)
        userModel.vehicles[randomIndex].maintenance.dumyData()
    }
}
