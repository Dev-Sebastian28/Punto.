import SwiftUI

struct MaintenanceFactory: FactoryQuickInfoCard {
    let vehicle: any Vehicle

    private var sortedMaintenances: [Maintenance] {
        vehicle.maintenances.sorted { $0.scheduledDate < $1.scheduledDate }
    }

    private var quickInfo: [QuickSummary] {
        let upcoming = vehicle.maintenances.filter { $0.scheduledDate > Date() }.count
        return [
            QuickSummary(title: "Upcoming", value: upcoming, color: .orange)
        ]
    }

    func make() -> some View {
        QuickInfoCard(
            title: "Maintenance",
            icon: "wrench.and.screwdriver.fill",
            iconColor: .orange,
            items: sortedMaintenances,
            quickInfo: quickInfo
        ) { maintenance in
            AnyView(MaintenanceRow(maintenance: maintenance))
        }
    }
}

// MARK: - Maintenance Row

private struct MaintenanceRow: View {
    let maintenance: Maintenance

    private var statusColor: Color {
        switch maintenance.status {
        case .completed: return .green
        case .inProgress: return .yellow
        case .scheduled: return .blue
        }
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(maintenance.title)
                    .font(.body.bold())
                Text(maintenance.notes ?? "No notes")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                StatusBadge(text: maintenance.status.rawValue, color: statusColor)
                DateBadge(date: maintenance.scheduledDate)
            }
        }
        .frame(maxHeight: 60)
    }
}