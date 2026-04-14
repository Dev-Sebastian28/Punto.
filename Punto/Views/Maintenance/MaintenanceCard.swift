//  MaintenanceCard.swift
//  Punto

import SwiftUI

struct MaintenanceCard: View {
    let part: MaintenanceCardData

    private var stateColor: Color {
        switch part.state {
        case .good:    Color(hex: "3B6D11")
        case .warning: Color(hex: "854F0B")
        case .overdue: Color(hex: "A32D2D")
        }
    }

    private var stateFill: Color {
        switch part.state {
        case .good:    Color(hex: "EAF3DE")
        case .warning: Color(hex: "FAEEDA")
        case .overdue: Color(hex: "FCEBEB")
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            metrics
            progressBar
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(stateColor.opacity(0.6), lineWidth: 0.8)
        )
    }

    // MARK: – Header
    private var header: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(stateFill)
                    .frame(width: 44, height: 44)
                Image(systemName: part.image)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(stateColor)
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .center, spacing: 8) {
                    Text(part.name)
                        .font(.system(.body, design: .monospaced).bold())
                    StateBadge(state: part.state, color: stateColor, fill: stateFill)
                }
                Text("Vida útil técnica: \(part.usefulDescription)")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    // MARK: – Tab bar

    // MARK: – Metrics grid
    private var metrics: some View {
        HStack(spacing: 8) {
            MetricTile(label: "Progreso", icon: "clock", value: "\(part.porcent)%", color: stateColor)
            MetricTile(label: "Restante", icon: "arrow.right", value: part.remaining, color: stateColor)
            MetricTile(label: "Próximo", icon: "calendar", value: "~45 días", color: .primary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
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
        Text(state.rawValue.uppercased())
            .font(.system(size: 9, weight: .bold))
            .tracking(0.6)
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(fill, in: Capsule())
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
                    .foregroundStyle(.tertiary)
            }
            Text(value)
                .font(.system(size: 13, weight: .medium, design: .monospaced))
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: – Color hex helper
extension Color {
    init(hex: String) {
        let v = Int(hex, radix: 16) ?? 0
        self.init(
            red:   Double((v >> 16) & 0xFF) / 255,
            green: Double((v >> 8)  & 0xFF) / 255,
            blue:  Double( v        & 0xFF) / 255
        )
    }
}

#Preview {
    MaintenanceCard(part: .init(image: "plus", name: "Aceite de motor", state: .overdue, usefulDescription: "3.000 - 5.0000 km", remaining: "2000", porcent: 90))
}
