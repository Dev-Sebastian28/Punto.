//
//  ExpenseViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/04/26.
//
import Foundation

@Observable
final class ExpenseViewModel {
    private var appState: AppState
    private let state: ExpensesState
    
    var selectedIndex: Int {
        state.selectedIndex
    }
    
    init(appState: AppState, state: ExpensesState) {
        self.appState = appState
        self.state = state
    }
    
    func addExpense(_ expense: Expense) {
        appState.user.vehicles[selectedIndex].expenses.append(expense)
    }
    
    func updateExpense(_ expense: Expense, at index: Int) {
        guard appState.user.vehicles[selectedIndex].expenses.indices.contains(index) else { return }
        
        appState.user.vehicles[selectedIndex].expenses[index] = expense
    }
    
}
