//
//  VehicleProtocolViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 7/04/26.
//

import Foundation

@Observable
final class ProtocoslListViewModel {
    private(set) var user: User
    var selectedVehicleIndex: Int = 0
    var seletedVehicle: Vehicle? {
        guard areVehicles else { return nil }
        guard user.vehicles.indices.contains(selectedVehicleIndex) else { return nil }
        return user.vehicles[selectedVehicleIndex]
    }
    
    var areVehicles: Bool {
        !user.vehicles.isEmpty
    }
    var areProtocols: Bool {
        guard areVehicles else { return false }
        return !(seletedVehicle?.protocols.isEmpty ?? false)
    }
    
    var protocols: [VehicleProtocol] {
        guard areVehicles else { return [] }
        return user.vehicles[selectedVehicleIndex].protocols
    }
    var protocolsCount: String {
        guard areProtocols else { return "" }
        return (seletedVehicle?.protocols.count.description) ?? ""
    }
    
    var selectedModelBrand: String {
        guard areVehicles else { return "" }
        if let seletedVehicle {
            return (seletedVehicle.vehicleInformation.model + " " + seletedVehicle.vehicleInformation.brand).capitalized
        } else {
            return ""
        }
    }
    var selectedPlate: String {
        if let seletedVehicle {
            return (seletedVehicle.vehicleInformation.model + " " + seletedVehicle.vehicleInformation.plate).uppercased()
        } else {
            return ""
        }
    }
    
    
    

    init(user: User) {
        self.user = user
    }
}




