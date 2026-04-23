//
//  ExpenseViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/04/26.
//
import Foundation

@Observable
final class ExpenseViewModel {
    private var user: User
    var selectedIndex: Int
    
    init(user: User, index: Int) {
        self.user = user
        self.selectedIndex = index
    }
    
    func addExpense(_ expense: Expense) {
        user.vehicles[selectedIndex].expenses.append(expense)
    }
    
    func updateExpense(_ expense: Expense, at index: Int) {
        guard user.vehicles[selectedIndex].expenses.indices.contains(index) else { return }
        
        user.vehicles[selectedIndex].expenses[index] = expense
    }
    
}
