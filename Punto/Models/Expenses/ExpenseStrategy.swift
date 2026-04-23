//
//  StrategyPatternExpenses.swift
//  Punto
//
//  Created by Sebastian Garcia on 11/03/26.
//

import Foundation

// I used strategy for this problem because i think is good way to add new functionality without breaking the second solid principle.

private protocol ExpenseStrategy {
    func apply(to expenses: [Expense]) -> [Expense]
}

private struct FilterByType: ExpenseStrategy, Equatable {
    let type: String

    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.filter { $0.type == type }
    }
}
private struct FilterIncomes: ExpenseStrategy, Equatable {
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.filter { $0.amount > 0 }
    }
}
private struct LossesFilter: ExpenseStrategy, Equatable {
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.filter { $0.amount < 0 }
    }
}
private struct SortByAmount: ExpenseStrategy, Equatable {
    let descending: Bool
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.sorted { descending ? $0.amount > $1.amount : $0.amount < $1.amount }
    }
}
private struct SortByDate: ExpenseStrategy, Equatable {
    let latestFirst: Bool
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses.sorted { latestFirst ? $0.date > $1.date : $0.date < $1.date }
    }
}
private struct DefaultStrategy: ExpenseStrategy, Equatable {
    func apply(to expenses: [Expense]) -> [Expense] {
        expenses
    }
}

enum ExpenseStrategies: CaseIterable {
    case filterByType
    case filterIncomes
    case lossesFilter
    case sortByAmountPostive
    case sortByAmountNegative
    case sortByDateLatestFirst
    case sortByDateOldestFirst
    case defaultStrategy
    
    static func perform(strategy: ExpenseStrategies, on expenses: [Expense]) -> [Expense] {
        switch strategy {
        case .filterByType:
            FilterByType(type: "").apply(to: expenses)
        case .filterIncomes:
            FilterIncomes().apply(to: expenses)
        case .lossesFilter:
            LossesFilter().apply(to: expenses)
        case .sortByAmountPostive:
            SortByAmount(descending: true).apply(to: expenses)
        case .sortByAmountNegative:
            SortByAmount(descending: false).apply(to: expenses)
        case .sortByDateLatestFirst:
            SortByDate(latestFirst: true).apply(to: expenses)
        case .sortByDateOldestFirst:
            SortByDate(latestFirst: false).apply(to: expenses)
        case .defaultStrategy:
            DefaultStrategy().apply(to: expenses)
        }
    }
}

