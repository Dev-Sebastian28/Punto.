//
//  ExpensesViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import Foundation

@Observable
final class ExpensesViewModel {
    var userModel: User
    var selectedVehicle: Int = 0
    var accountingService: AccountingService
    var filteredCollection: [Expense]

    private var selectedVehicleExpenses: [Expense] {
        guard userModel.vehicles.indices.contains(selectedVehicle) else {
            return []
        }
        return userModel.vehicles[selectedVehicle].expenses
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
        selectedVehicleExpenses.count
    }

    var expenses: [Expense] {
        selectedVehicleExpenses
    }
    
    func addNewExpense(name: String, description: String, amount: Double, date: Date, type: String  ) {
        let newExpense = Expense(name: name, description: description, amount: amount, date: date, type: type)
        userModel.vehicles[selectedVehicle].expenses.addExpense(expense: newExpense)
        syncExpensesState()
    }

    func updateExpenses(_ expenses: [Expense]) {
        guard userModel.vehicles.indices.contains(selectedVehicle) else {
            accountingService = AccountingService(entries: [])
            filteredCollection = []
            return
        }

        userModel.vehicles[selectedVehicle].expenses = expenses
        syncExpensesState()
    }

    func resetFilters() {
        filteredCollection = expenses
    }

    private func syncExpensesState() {
        let updatedExpenses = selectedVehicleExpenses
        accountingService = AccountingService(entries: updatedExpenses)
        filteredCollection = updatedExpenses
    }
    
    init(
        userModel: User,
        selectedVehicle: Int,
        accountingService: AccountingService? = nil,
        filteredCollection: [Expense]? = nil
    ) {
        let selectedVehicleExpenses = userModel.vehicles.indices.contains(selectedVehicle)
            ? userModel.vehicles[selectedVehicle].expenses
            : []

        self.userModel = userModel
        self.selectedVehicle = selectedVehicle
        self.accountingService = accountingService ?? AccountingService(entries: selectedVehicleExpenses)
        self.filteredCollection = filteredCollection ?? selectedVehicleExpenses
    }
}
