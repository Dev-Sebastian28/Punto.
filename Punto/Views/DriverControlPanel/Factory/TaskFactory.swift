//
//  TaskFactory.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//


import SwiftUI

struct TaskFactory: FactoryQuickInfoCard {
    let vehicle: any Vehicle

    private var sortedTasks: [VTask] {
        vehicle.tasks.sorted {
            $0.importance == .high && $0.status == .pending ? true :
            $1.importance == .high ? false :
            $0.importance.rawValue > $1.importance.rawValue
        }
    }

    private var quickInfo: [QuickSummary] {
        let pending = vehicle.tasks.filter { $0.status == .pending }.count
        let high    = vehicle.tasks.filter { $0.importance == .high }.count
        return [
            QuickSummary(title: "Pending", value: pending, color: .orange),
            QuickSummary(title: "High",    value: high,    color: .red)
        ]
    }

    func make() -> some View {
        QuickInfoCard(
            title: "Tasks",
            icon: "list.dash",
            iconColor: .blue,
            items: sortedTasks,
            quickInfo: quickInfo
        ) { task in
            AnyView(TaskRow(task: task))
        }
    }
}

// MARK: - Task Row

private struct TaskRow: View {
    let task: VTask

    private var importanceColor: Color {
        switch task.importance {
        case .high:   return .red
        case .medium: return .yellow
        case .low:    return .green
        }
    }

    var body: some View {
        HStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: 5)
                .foregroundStyle(importanceColor)

            VStack(alignment: .leading) {
                HStack {
                    Text(task.title)
                    Spacer()
                    StatusBadge(text: task.importance.rawValue, color: importanceColor)
                    DateBadge(date: task.date)
                }
                Text(task.description ?? "No description")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxHeight: 75)
    }
}
