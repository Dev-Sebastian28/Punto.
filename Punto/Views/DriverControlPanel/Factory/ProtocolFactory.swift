//
//  ProtocolFactory.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//


import SwiftUI

struct ProtocolFactory: FactoryQuickInfoCard {
    let vehicle: any Vehicle

    private var sortedProtocols: [VehicleProtocol] {
        vehicle.protocols
    }

    func make() -> some View {
        QuickInfoCard(
            title: "Protocols",
            icon: "doc.badge.checkmark",
            iconColor: .purple,
            items: sortedProtocols,
            quickInfo: []
        ) { proto in
            AnyView(ProtocolRow(proto: proto))
        }
    }
}

// MARK: - Protocol Row

private struct ProtocolRow: View {
    let proto: VehicleProtocol

    private var isExpired: Bool { false }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(proto.name)
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
                DateBadge(date: .now)
            }
        }
        .frame(maxHeight: 60)
    }
}
