//
//  ExpenseListViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/04/26.
//
import Foundation

@Observable
final class ExpenseListViewModel {
    private var user: User
    private let state: ExpensesState
    var strategy: ExpenseStrategies = .defaultStrategy
    
    private var expenses: [Expense] {
        user.vehicles[state.selectedIndex].expenses
        
    }
    
    var filteredExpenses: [Expense] {
        ExpenseStrategies.perform(strategy: strategy, on: expenses)
    }
    
    func reset() {
        strategy = .defaultStrategy
    }
    
    init(user: User, state: ExpensesState) {
        self.user = user
        self.state = state

    }
}
