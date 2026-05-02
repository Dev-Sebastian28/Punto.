//
//  ExpensesViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 27/03/26.
//

import Foundation

@Observable
final class ExpensesViewModel {
    private var appState: AppState
    private let state: ExpensesState
    var expenses: [Expense] {
        appState.user.vehicles[state.selectedIndex].expenses
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
    
    init(AppState: AppState, state: ExpensesState) {
        self.appState = AppState
        self.state = state
    }
}

