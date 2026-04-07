//
//  StrategyPatternExpenses.swift
//  Punto
//
//  Created by Sebastian Garcia on 11/03/26.
//

import Foundation

// I used strategy for this problem because i think is good way to add new functionality without breaking the second solid principle.

protocol ExpenseStrategy {
    func apply(to expenses: [Expense]) -> [Expense]
}


struct FilterByType: ExpenseStrategy {
    let type: String

    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.filter { $0.type == type }
    }
}

struct FilterIncomes: ExpenseStrategy {
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.filter { $0.amount > 0 }
    }
}

struct LossesFilter: ExpenseStrategy {
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.filter { $0.amount < 0 }
    }
}

struct SortByAmount: ExpenseStrategy {
    let descending: Bool
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.sorted { descending ? $0.amount > $1.amount : $0.amount < $1.amount }
    }
}
struct SortByDate: ExpenseStrategy {
    let latestFirst: Bool
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.sorted { latestFirst ? $0.date > $1.date : $0.date < $1.date }
    }
}
