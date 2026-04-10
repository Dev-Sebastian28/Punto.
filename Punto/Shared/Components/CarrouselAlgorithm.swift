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

struct TaskCarrouselAlgorithm: CarrouselAlgorithm {
    func perform(vehicle: any Vehicle) -> [QuickSummary2] {
        let totalTasks = vehicle.tasks.count
        let doneTasks = vehicle.tasks.filter({ $0.status == .done }).count
        let pendingTasks = vehicle.tasks.filter({ $0.status == .pending }).count

        return [
            QuickSummary2(title: "Total tasks", value: totalTasks, color: .blue),
            QuickSummary2(title: "Done tasks", value: doneTasks, color: .green),
            QuickSummary2(title: "Pending tasks", value: pendingTasks, color: .orange)
        ]
    }
}

struct ProtocolsCarrouselAlgorithm: CarrouselAlgorithm {
    func perform(vehicle: any Vehicle) -> [QuickSummary2] {
        let totalhigh = vehicle.protocols.filter({ $0.importance == .high }).count
        let totalmid = vehicle.protocols.filter({ $0.importance == .medium }).count
        let totallow = vehicle.protocols.filter({ $0.importance == .low }).count

        return [
            QuickSummary2(title: "High", value: totalhigh, color: .red),
            QuickSummary2(title: "Mid", value: totalmid, color: .yellow),
            QuickSummary2(title: "Low", value: totallow, color: .gray)
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

struct ExpenseCarrouselAlgorithm: CarrouselAlgorithm {
    func perform(vehicle: any Vehicle) -> [QuickSummary2] {
        let totalTasks = vehicle.tasks.count
        let doneTasks = vehicle.tasks.filter({ $0.status == .done })
        let pendingTasks = vehicle.tasks.filter({ $0.status == .pending })

        return [
            QuickSummary2(title: "Total tasks", value: totalTasks, color: .blue),
            QuickSummary2(title: "Done tasks", value: doneTasks.count, color: .green),
            QuickSummary2(title: "Pending tasks", value: pendingTasks.count, color: .orange)
        ]
    }
}
