//
//  ProtocolFormsViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/04/26.
//

import Foundation

@Observable
final class ProtocolViewModel {
    private var user: User
    var selectedVehicleIndex: Int = 0
    
    func addProtocol(_ element: VehicleProtocol) {
        user.vehicles[selectedVehicleIndex].protocols.append(element)
    }
    
    func updateProtocol(_ element: VehicleProtocol, at index: Int) {
        user.vehicles[selectedVehicleIndex].protocols.updateProtocol(index: index, newValue: element)
    }
    
    func eliminateProtocol(at index: Int) {
        user.vehicles[selectedVehicleIndex].protocols.removeProtocol(index: index)
    }
    
    init(user: User, selectedVehicleIndex: Int) {
        self.user = user
        self.selectedVehicleIndex = selectedVehicleIndex
    }
}
