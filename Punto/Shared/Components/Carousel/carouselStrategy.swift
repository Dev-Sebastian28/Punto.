//
//  CarrouselAlgorithm.swift
//  Punto
//
//  Created by Sebastian Garcia on 9/04/26.
//
import Foundation
import SwiftUI

// MARK: - Protocol

protocol CarouselStrategy {
    func perform(vehicle: any Vehicle) -> [QuickSummary]
}

// MARK: - Tasks

struct TaskAlgorithm: CarouselStrategy {
    func perform(vehicle: any Vehicle) -> [QuickSummary] {
        let tasks = vehicle.tasks
        let total   = tasks.count
        let done    = tasks.filter { $0.status == .done }.count
        let pending = tasks.filter { $0.status == .pending }.count

        return [
            QuickSummary(title: "Total",   value: total,   color: .blue),
            QuickSummary(title: "Done",    value: done,    color: .green),
            QuickSummary(title: "Pending", value: pending, color: .orange)
        ]
    }
}

// MARK: - Protocols

struct ProtocolsAlgorithm: CarouselStrategy {
    func perform(vehicle: any Vehicle) -> [QuickSummary] {
        let protocols = vehicle.protocols
        let high = protocols.filter { $0.importance == .high   }.count
        let mid  = protocols.filter { $0.importance == .medium }.count
        let low  = protocols.filter { $0.importance == .low    }.count

        return [
            QuickSummary(title: "High", value: high, color: .red),
            QuickSummary(title: "Mid",  value: mid,  color: .yellow),
            QuickSummary(title: "Low",  value: low,  color: .gray)
        ]
    }
}

// MARK: - Maintenance

struct MaintenanceCarouselAlgorithm: CarouselStrategy {
    func perform(vehicle: any Vehicle) -> [QuickSummary] {
        var overdue = 0, warning = 0, good = 0

        for part in vehicle.maintenance {
            let analyser = MaintenanceAnaliser(comp: part)
            print("[\(part.vehiclePart.partName)] traveled: \(analyser.traveled), state: \(analyser.calculateState())")
            
            switch analyser.calculateState() {
            case .overdue: overdue += 1
            case .warning: warning += 1
            case .good:    good    += 1
            }
        }

        return [
            QuickSummary(title: "Overdue", value: overdue, color: .red),
            QuickSummary(title: "Warning", value: warning, color: .yellow),
            QuickSummary(title: "Good",    value: good,    color: .green)
        ]
    }
}

// MARK: - Expenses

struct ExpenseAlgorithm: CarouselStrategy {
    func perform(vehicle: any Vehicle) -> [QuickSummary] {
        let expenses = vehicle.expenses
        let total   = expenses.count
        let incomes = expenses.filter { $0.amount > 0 }.count
        let losses  = expenses.filter { $0.amount < 0 }.count

        return [
            QuickSummary(title: "Total",   value: total,   color: .blue),
            QuickSummary(title: "Incomes", value: incomes, color: .green),
            QuickSummary(title: "Losses",  value: losses,  color: .orange)
        ]
    }
}
