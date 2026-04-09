//
//  ExpensesViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import Foundation

@Observable
final class ExpensesViewModel {
    private(set) var userModel: User
    var selectedVehicle: Int = 0
    var accountingService: AccountingService
    var filteredCollection: [Expense]

    var vehicles: [Vehicle] {
        userModel.vehicles
    }
        
    var balance: Double {
        accountingService.calculateTotalBalance()
    }
    
    var profit: Double {
        accountingService.calculateTotalIncomes()
    }
    
    var losses: Double {
        accountingService.calculateTotalExpenses()
    }
    
    var totalExpenses: Int {
        vehicles[selectedVehicle].expenses.count
    }

    var expenses: [Expense] {
        vehicles[selectedVehicle].expenses
    }
    
    var selectedVehicleInfo: VehicleInformation {
        userModel.vehicles[selectedVehicle].vehicleInformation
    }
    
    func addNewExpense(name: String, description: String, amount: Double, date: Date, type: String  ) {
        let newExpense = Expense(name: name, description: description, amount: amount, date: date, type: type)
        userModel.vehicles[selectedVehicle].expenses.addExpense(expense: newExpense)
    }

    func resetFilters() {
        filteredCollection = expenses
    }
    
    init(userModel: User,selectedVehicle: Int,accountingService: AccountingService? = nil,filteredCollection: [Expense]? = nil ) {
        
        let selectedVehicleExpenses = userModel.vehicles.indices.contains(selectedVehicle)
            ? userModel.vehicles[selectedVehicle].expenses
            : []

        self.userModel = userModel
        self.selectedVehicle = selectedVehicle
        self.accountingService = accountingService ?? AccountingService(entries: selectedVehicleExpenses)
        self.filteredCollection = filteredCollection ?? selectedVehicleExpenses
    }
}
