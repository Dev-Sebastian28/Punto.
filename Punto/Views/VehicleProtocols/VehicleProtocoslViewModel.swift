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
    var vehicles: [Vehicle] { user.vehicles }
    var selectedVehicle: Int = 0
    
    var quickInfo: VehicleInformation { vehicles[selectedVehicle].vehicleInformation }
    var protocols: [VehicleProtocol] { vehicles[selectedVehicle].protocols }
    var protocolCount: Int { protocols.count }
    
    init(user: User) {
        self.user = user
    }
}


