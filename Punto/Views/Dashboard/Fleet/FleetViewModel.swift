//
//  FleetViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/04/26.
//

import Foundation

@Observable
final class FleetViewModel {
    private(set) var user: User
    var vehicles: [Vehicle] { user.vehicles }
    
    var filterCollection: [any Vehicle]
    
    var enoughVehiclesToQuickInfo: Bool { vehiclesCount >= 3 }
    
    var activeVehiclesCount: Int {
        vehicles.filter({ $0.isActive == true }).count
    }

    var inactiveVehiclesCount: Int {
        vehicles.filter({ $0.isActive == false }).count
    }
    
    var manteinicesCount: Int {
        0
    }
    
    var vehiclesCount: Int { vehicles.count }
    
    var totalBalance: Double {
        var total: Double = 0
        for vehicle in vehicles {
            total += vehicle.expenses.reduce(0) { $0 + $1.amount }
        }
        return total
    }
    
    
    init(user: User) {
        self.user = user
        self.filterCollection = user.vehicles
    }
}
