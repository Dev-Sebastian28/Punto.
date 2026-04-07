//
//  ExpensesAccountingService.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/02/26.
//

import Foundation




struct AccountingService {

    var entries: [Expense]

    func calculateTotalBalance() -> Double {
        entries.reduce(0) { partialResult, expenses in
            partialResult + expenses.amount
        }
    }

    func calculateTotalIncomes() -> Double {
        entries.reduce(0) { partialResult, expenses in
            if expenses.amount > 0 {
                 partialResult + expenses.amount
            } else {
                0
            }
        }
    }

    func calculateTotalExpenses() -> Double {
        entries.reduce(0) { partialResult, expenses in
            if expenses.amount < 0 {
                 partialResult + expenses.amount
            } else {
                0
            }
        }
    }
}
