//
//  MaintenanceFactory.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//


import SwiftUI

struct MaintenanceFactory: ViewFactoryInterface {
    let vehicle: any Vehicle

    private var sortedMaintenances: [VehiclePartWrapper] {
        vehicle.maintenance
    }
    
    private var quickInfo: [QuickSummary] {
        let pending = vehicle.tasks.filter { $0.status == .pending }.count
        let high    = vehicle.tasks.filter { $0.importance == .high }.count
        return [
            QuickSummary(title: "Warning", value: pending, color: .yellow),
            QuickSummary(title: "Critical",    value: high,    color: .red)
        ]
    }

    func make() -> some View {
        QuickInfoCard(
            title: "Maintenan...",
            icon: "wrench.and.screwdriver.fill",
            color: .gray,
            items: sortedMaintenances,
            quickInfo: quickInfo
        ) { maintenance in
            AnyView(MaintenanceRow(maintenance: maintenance))
        }
    }
}

// MARK: - Maintenance Row

private struct MaintenanceRow: View {
    let maintenance: VehiclePartWrapper
    private var state: MaintenanceState {
        MaintenanceAnaliser(comp: maintenance).calculateState()
    }
    private var statusColor: Color {
        switch state {
        case .good : return .green
        case .warning : return .yellow
        case .overdue : return .red
        }
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(maintenance.vehiclePart.partName)
                    .font(.body.bold())
                Text(maintenance.vehiclePart.category.capitalized)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                StatusBadge(text: state.rawValue, color: statusColor)
                DateBadge(date: Date())
            }
        }
        .frame(maxHeight: 60)
    }
}
