//
//  FleetViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/04/26.
//

import Foundation

@Observable
final class FleetViewModel {
    private var appState: AppState
    var vehicles: [Vehicle] { appState.user.vehicles }
    var hasVehicles: Bool { !vehicles.isEmpty }
    var enoughVehiclesToQuickInfo: Bool { vehicles.count >= 3 }
    
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
    var vehiclesCount: String { vehicles.count.description }
    
    private var totalExpenses: [Expense] {
        var expenses: [Expense] = []
        for vehicle in vehicles {
            expenses.append(contentsOf: vehicle.expenses)
        }
        return expenses
    }
    var totalBalance: String {
        ExpensesCalculator(entries: totalExpenses).calculateTotalBalance().formatted(.number.grouping(.automatic)).description
    }
    
    init(appState: AppState) {
        self.appState = appState
    }
}
