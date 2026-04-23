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
    private var seletedVehicleInfo: VehicleInformation {
        user.vehicles[selectedVehicleIndex].vehicleInformation
    }
    
    var protocols: [VehicleProtocol] {
        user.vehicles[selectedVehicleIndex].protocols
    }
    var areProtocols: Bool {
        return !protocols.isEmpty
    }
    var protocolsCount: String {
        protocols.count.description
    }
    
    var selectedModelBrand: String {
        seletedVehicleInfo.brand + " " + seletedVehicleInfo.model
    }
    var selectedPlate: String {
        seletedVehicleInfo.plate.uppercased()
    }
    
    init(user: User) {
        self.user = user
    }
}




