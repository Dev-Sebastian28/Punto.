//
//  ExpensesViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import Foundation
import Observation // Required for @Observable

@Observable
final class ExpensesViewModel {
    private var userModel: User
    var selectedVehicleIndex: Int = 0
    
    // Safety check for empty vehicle list
    private var currentVehicle: Vehicle? {
        guard userModel.vehicles.indices.contains(selectedVehicleIndex) else { return nil }
        return userModel.vehicles[selectedVehicleIndex]
    }

    var vehicles: [Vehicle] { userModel.vehicles }
    
    // Computed property ensures UI always gets the latest list for the selected vehicle
    var expenses: [Expense] {
        currentVehicle?.expenses ?? []
    }

    // Dynamic ExpensesCalculator: Always uses the current vehicle's data
    var accountingService: ExpensesCalculator {
        ExpensesCalculator(entries: expenses)
    }

    // Financial summaries computed on-the-fly
    var balance: String { accountingService.calculateTotalBalance().description }
    var profit: String { accountingService.calculateTotalIncomes().description }
    var losses: String { accountingService.calculateTotalExpenses().description }
    var totalExpensesCount: Int { expenses.count }

    var selectedVehicleInfo: VehicleInformation? {
        currentVehicle?.vehicleInformation
    }

    init(userModel: User) {
        self.userModel = userModel
    }

    func addNewExpense(name: String, description: String, amount: Double, date: Date, type: String) {
        let newExpense = Expense(name: name, description: description, amount: amount, date: date, type: type)
        if userModel.vehicles.indices.contains(selectedVehicleIndex) {
            userModel.vehicles[selectedVehicleIndex].expenses.append(newExpense)
        }
    }
}


