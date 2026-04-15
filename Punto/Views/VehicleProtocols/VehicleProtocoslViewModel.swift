//
//  VehicleProtocolViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 7/04/26.
//

import Foundation

@Observable
final class VehicleProtocoslViewModel {
    private(set) var user: User
    var selectedVehicleIndex: Int = 0
    
    var areVehicles: Bool {
        !user.vehicles.isEmpty
    }
    var areProtocols: Bool {
        guard areVehicles else { return false }
        return !user.vehicles[selectedVehicleIndex].protocols.isEmpty
    }
    var vehicles: [Vehicle] {
        user.vehicles
    }
    
    var protocols: [VehicleProtocol] {
        guard areVehicles else { return [] }
        return user.vehicles[selectedVehicleIndex].protocols
    }
    
    var protocolsCount: String {
        guard areProtocols else { return "" }
        return user.vehicles[selectedVehicleIndex].protocols.count.description
    }
    
    var selectedModelBrand: String {
        guard areVehicles else { return "" }
        return (user.vehicles[selectedVehicleIndex].vehicleInformation.model + " " + user.vehicles[selectedVehicleIndex].vehicleInformation.brand).capitalized
    }
    
    var selectedPlate: String {
        guard areVehicles else { return "" }
        return user.vehicles[selectedVehicleIndex].vehicleInformation.plate
    }

    init(user: User) {
        self.user = user
    }
}




