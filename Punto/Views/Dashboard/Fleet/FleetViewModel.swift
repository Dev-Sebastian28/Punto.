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
    var enoughVehiclesToQuickInfo: Bool { vehiclesCount >= 3 }
    
    var activeVehiclesCount: Int {
        vehicles.filter({ $0.isActive == true }).count
    }
    var inactiveVehiclesCount: Int {
        vehicles.filter({ $0.isActive == false }).count
    }
    
    var manteinicesCount: Int {
        var count: Int = 0
        for vehicle in vehicles {
            for maintenance in vehicle.maintenance {
                let state = MaintenanceAnaliser(comp: maintenance).calculateState()
                if state == .overdue || state == .warning {
                    count += 1
                }
            }
        }
        return count
    }
    var vehiclesCount: Int { vehicles.count }
    
    var totalExpenses: [Expense] {
        var expenses: [Expense] = []
        for vehicle in vehicles {
            expenses.append(contentsOf: vehicle.expenses)
        }
        return expenses
    }
    var totalBalance: Double {
        ExpensesCalculator(entries: totalExpenses).calculateTotalBalance()
    }
    
    init(user: User) {
        self.user = user
    }
}
