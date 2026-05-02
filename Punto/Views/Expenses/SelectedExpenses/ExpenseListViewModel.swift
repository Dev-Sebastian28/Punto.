//
//  ExpenseListViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/04/26.
//
import Foundation

@Observable
final class ExpenseListViewModel {
    private var appState: AppState
    private let state: ExpensesState
    var strategy: ExpenseStrategies = .defaultStrategy
    
    private var expenses: [Expense] {
        appState.user.vehicles[state.selectedIndex].expenses
        
    }
    
    var filteredExpenses: [Expense] {
        ExpenseStrategies.perform(strategy: strategy, on: expenses)
    }
    
    func reset() {
        strategy = .defaultStrategy
    }
    
    init(appState: AppState, state: ExpensesState) {
        self.appState = appState
        self.state = state

    }
}
