//
//  ProtocolFactory.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/04/26.
//


import SwiftUI

struct ProtocolFactory: ViewFactoryInterface {
    let vehicle: any Vehicle

    private var sortedProtocols: [VehicleProtocol] {
        vehicle.protocols
    }
    
    private var quickInfo: [QuickSummary] {
        let high = vehicle.protocols.filter { $0.importance == .high }.count
        let medium = vehicle.protocols.filter { $0.importance == .medium }.count
        let low = vehicle.protocols.filter { $0.importance == .low }.count
        
        return [
            QuickSummary(title: "low", value: low, color: .green),
            QuickSummary(title: "mid", value: medium, color: .yellow),
            QuickSummary(title: "High", value: high, color: .red)
        ]
    }

    func make() -> some View {
        QuickInfoCard(
            title: "Protocols",
            icon: "shield.fill",
            color: .yellow,
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
