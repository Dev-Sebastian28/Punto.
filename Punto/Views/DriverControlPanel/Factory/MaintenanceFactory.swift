//
//  MaintenanceFactory.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//


import SwiftUI

struct MaintenanceFactory: FactoryQuickInfoCard {
    let vehicle: any Vehicle

    private var sortedMaintenances: [VehiclePartWrapper] {
        vehicle.maintenance
    }


    func make() -> some View {
        QuickInfoCard(
            title: "Maintenance",
            icon: "wrench.and.screwdriver.fill",
            iconColor: .orange,
            items: sortedMaintenances,
            quickInfo: []
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
