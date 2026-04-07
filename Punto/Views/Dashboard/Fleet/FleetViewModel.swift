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
    var manteinices: [MaintainableComponent] {
        var colection = [MaintainableComponent]()
        for vehicle in vehicles {
            colection.append(contentsOf: vehicle.maintenance )
        }
        return colection
    }
    
    var filterCollection: [any Vehicle]
    
    var enoughVehiclesToQuickInfo: Bool { vehiclesCount >= 3 }
    
    var activeVehiclesCount: Int {
        vehicles.filter({ $0.isActive == true }).count
    }

    var inactiveVehiclesCount: Int {
        vehicles.filter({ $0.isActive == false }).count
    }
    
    var manteinicesCount: Int {
        
        let total = manteinices.reduce(0) { partialResult, maintainableComponent in
            let state = MaintenanceLogic(
                componet: maintainableComponent,
                factors: 1.0,
                unitMeasurement: 0
            ).analysisState()

            if state == .critical || state == .warning {
                return partialResult + 1
            } else {
                return partialResult
            }
        }
        return total
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
