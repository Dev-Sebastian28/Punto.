//
//  ProtocolFormsViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/04/26.
//

import Foundation

@Observable
final class ProtocolFormsViewModel {
    private(set) var user: User
    var selectedVehicleIndex: Int? = nil
    
    func addProtocol(_ element: VehicleProtocol) {
        if let selectedVehicleIndex, user.vehicles.indices.contains(selectedVehicleIndex) {
            user.vehicles[selectedVehicleIndex].protocols.addProtocol(element)
        }
    }
    
    func updateProtocol(_ element: VehicleProtocol, at index: Int) {
        if let selectedVehicleIndex, user.vehicles.indices.contains(selectedVehicleIndex) {
            user.vehicles[selectedVehicleIndex].protocols.updateProtocol(index: index, newValue: element)
        }
    }
    
    func eliminateProtocol(at index: Int) {
        if let selectedVehicleIndex, user.vehicles.indices.contains(selectedVehicleIndex) {
            user.vehicles[selectedVehicleIndex].protocols.removeProtocol(index: index)
        }
    }
    
    init(user: User, selectedVehicleIndex: Int?) {
        self.user = user
        self.selectedVehicleIndex = selectedVehicleIndex
    }
}
