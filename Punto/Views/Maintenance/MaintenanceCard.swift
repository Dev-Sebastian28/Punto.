//  MaintenanceCard.swift
//  Punto

import SwiftUI

struct MaintenanceCard: View {
    let part: MaintenanceCardData

    private var stateColor: Color {
        switch part.state {
        case .good:    .green
        case .warning: .yellow
        case .overdue: .red
        }
    }

    private var stateFill: Color {
        switch part.state {
        case .good:    .green.opacity(0.1)
        case .warning: .yellow.opacity(0.1)
        case .overdue: .red.opacity(0.1)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            metrics
            progressBar
        }
        .background(stateFill)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(stateColor.opacity(0.6), lineWidth: 2)
        )
    }

    // MARK: – Header
    private var header: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(stateFill)
                    .frame(width: 54, height: 54)
                Image(systemName: part.image)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(stateColor)
            }

            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    Text(part.name)
                        .font(.title3).bold()
                    
                    Spacer()
                    
                    StateBadge(
                        state: part.state,
                        color: stateColor,
                        fill: stateFill
                    )
                }
                Text("Vida útil técnica: \(part.usefulDescription)")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                Text("Vida útil técnica: \(part.usefulDescription)")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    // MARK: – Metrics
    private var metrics: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                MetricTile(label: "Progreso", icon: "clock", value: "\(part.porcent)%", color: stateColor)
                MetricTile(label: "Restante", icon: "arrow.right", value: part.remaining, color: stateColor)
                MetricTile(label: "Próximo", icon: "calendar", value: "~45 días", color: .primary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
        }
    }

    // MARK: – Progress bar
    private var progressBar: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Label("Vida útil restante", systemImage: "waveform.path.ecg")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(part.porcent)%")
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.systemGray5)).frame(height: 8)
                    Capsule()
                        .fill(stateColor)
                        .frame(width: geo.size.width * CGFloat(part.porcent) / 100, height: 8)
                }
            }
            .frame(height: 8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .padding(.top, 4)
    }
}

// MARK: – Subcomponents

private struct StateBadge: View {
    let state: MaintenanceState
    let color: Color
    let fill: Color

    var body: some View {
        Text(state.rawValue.uppercased()).bold()
            .underline()
            .font(.title3)
            .foregroundStyle(color)
    }
}
private struct MetricTile: View {
    let label: String
    let icon: String
    let value: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 9))
                    .foregroundStyle(.tertiary)
                Text(label)
                    .font(.system(size: 9, weight: .semibold))
                    .tracking(0.5)
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)
            }
            Text(value)
                .font(.system(size: 13, weight: .medium, design: .monospaced))
                .foregroundStyle(color)
        }
        .customBackground(color: .gray.opacity(0.2))
    }
}

#Preview {
    MaintenanceCard(
        part: .init(
            image: "plus",
            name: "Aceite de motor",
            state: .good,
            usefulDescription: "3.000 - 5.0000 km",
            remaining: "2000",
            porcent: 90
        )
    )
}
