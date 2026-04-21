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
    var strategy: ExpenseStrategy = DefaultStrategy()
    
    private var expenses: [Expense] {
        user.vehicles[state.selectedIndex].expenses
        
    }
    
    var filteredExpenses: [Expense] {
        strategy.apply(to: expenses)
    }
    
    func reset() {
       strategy = DefaultStrategy()
    }
    
    init(user: User, state: ExpensesState) {
        self.user = user
        self.state = state

    }
}
