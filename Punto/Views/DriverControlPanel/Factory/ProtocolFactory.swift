import SwiftUI

struct ProtocolFactory: FactoryQuickInfoCard {
    let vehicle: any Vehicle

    private var sortedProtocols: [VehicleProtocol] {
        vehicle.protocols.sorted { $0.dueDate < $1.dueDate }
    }

    private var quickInfo: [QuickSummary] {
        let expired = vehicle.protocols.filter { $0.dueDate < Date() }.count
        return [
            QuickSummary(title: "Expired", value: expired, color: .red)
        ]
    }

    func make() -> some View {
        QuickInfoCard(
            title: "Protocols",
            icon: "doc.badge.checkmark",
            iconColor: .purple,
            items: sortedProtocols,
            quickInfo: quickInfo
        ) { proto in
            AnyView(ProtocolRow(proto: proto))
        }
    }
}

// MARK: - Protocol Row

private struct ProtocolRow: View {
    let proto: VehicleProtocol

    private var isExpired: Bool { proto.dueDate < Date() }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(proto.title)
                    .font(.body.bold())
                Text(proto.description ?? "No description")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                StatusBadge(
                    text: isExpired ? "Expired" : "Active",
                    color: isExpired ? .red : .green
                )
                DateBadge(date: proto.dueDate)
            }
        }
        .frame(maxHeight: 60)
    }
}