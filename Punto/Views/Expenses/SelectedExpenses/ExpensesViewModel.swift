//
//  ExpensesViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import Foundation

@Observable
final class ExpensesViewModel {
    private var user: User
    private let state: ExpensesState
    var expenses: [Expense] {
        user.vehicles[state.selectedIndex].expenses
}
    var accountingService: ExpensesCalculator {
    ExpensesCalculator(entries: expenses)
}
    
    // Quick balance information:
    var balance: String {
        accountingService.calculateTotalBalance().description
    }
    var profit: String {
        accountingService.calculateTotalIncomes().description
    }
    var losses: String {
        accountingService.calculateTotalExpenses().description
    }
    var totalExpensesCount: String {
        expenses.count.description
    }
    
    init(user: User, state: ExpensesState) {
        self.user = user
        self.state = state
    }
}





//func addNewExpense(name: String, description: String, amount: Double, date: Date, type: String) {
//    let newExpense = Expense(name: name, description: description, amount: amount, date: date, type: type)
//    if user.vehicles.indices.contains(selectedVehicleIndex) {
//        user.vehicles[selectedVehicleIndex].expenses.append(newExpense)
//    }
//}
