//
//  CarrouselAlgorithm.swift
//  Punto
//
//  Created by Sebastian Garcia on 9/04/26.
//
import Foundation
import SwiftUI

protocol CarrouselAlgorithm {
    func perform(vehicle: any Vehicle) -> [QuickSummary2]
}

struct TasklAlgorithm: CarrouselAlgorithm {
    func perform(vehicle: any Vehicle) -> [QuickSummary2] {
        let total = vehicle.tasks.count
        let done = vehicle.tasks.filter({ $0.status == .done }).count
        let pending = vehicle.tasks.filter({ $0.status == .pending }).count

        return [
            QuickSummary2(title: "Total tasks", value: total, color: .blue),
            QuickSummary2(title: "Done tasks", value: done, color: .green),
            QuickSummary2(title: "Pending tasks", value: pending, color: .orange)
        ]
    }
}

struct ProtocolsAlgorithm: CarrouselAlgorithm {
    func perform(vehicle: any Vehicle) -> [QuickSummary2] {
        let high = vehicle.protocols.filter({ $0.importance == .high }).count
        let mid = vehicle.protocols.filter({ $0.importance == .medium }).count
        let low = vehicle.protocols.filter({ $0.importance == .low }).count

        return [
            QuickSummary2(title: "High", value: high, color: .red),
            QuickSummary2(title: "Mid", value: mid, color: .yellow),
            QuickSummary2(title: "Low", value: low, color: .gray)
        ]
    }
}

struct MaintenanceCarrouselAlgorithm: CarrouselAlgorithm {
    func perform(vehicle: any Vehicle) -> [QuickSummary2] {
        let critical = vehicle.maintenance.reduce(0) { partialResult, MaintainableComponent in
            let maintenance = MaintenanceLogic(componet: MaintainableComponent, factors: 0.0, unitMeasurement: 1000)
            if maintenance.analysisState() == .critical {
                return partialResult + 1
            } else { return 0 }
        }
        
        let warning = vehicle.maintenance.reduce(0) { partialResult, MaintainableComponent in
            let maintenance = MaintenanceLogic(componet: MaintainableComponent, factors: 0.0, unitMeasurement: 1000)

            if maintenance.analysisState() == .warning {
                return partialResult + 1
            } else { return 0 }
        }
        
        let well = vehicle.maintenance.reduce(0) { partialResult, MaintainableComponent in
            let maintenance = MaintenanceLogic(componet: MaintainableComponent, factors: 0.0, unitMeasurement: 1000)

            if maintenance.analysisState() == .good {
                return partialResult + 1
            } else { return 0 }
        }

        return [
            QuickSummary2(title: "Critical", value: critical, color: .red),
            QuickSummary2(title: "Warning", value: warning, color: .yellow),
            QuickSummary2(title: "Well", value: well, color: .green)
        ]
    }
}

struct ExpenseAlgorithm: CarrouselAlgorithm {
    func perform(vehicle: any Vehicle) -> [QuickSummary2] {
        let total = vehicle.expenses.count
        let incomes = vehicle.expenses.filter({ $0.amount > 0 }).count
        let losses = vehicle.expenses.filter({ $0.amount < 0 }).count

        return [
            QuickSummary2(title: "Total", value: total, color: .blue),
            QuickSummary2(title: "Incomes", value: incomes, color: .green),
            QuickSummary2(title: "Losses", value: losses, color: .orange)
        ]
    }
}
