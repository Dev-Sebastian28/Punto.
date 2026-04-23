//
//  CargoDetailView.swift
//  Punto
//
//  Created by Sebastian Garcia on 21/04/26.
//

// CargoDetailView.swift

import SwiftUI

struct CargoDetailView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                HeroHeader()
                VStack(spacing: 12) {
                    RouteDetail()
                    CargoDescription()
                    CargoVehicleRequirements()
                    AcceptButton()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Hero Header

struct HeroHeader: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background gradient
            LinearGradient(
                colors: [Color(hex: "0C447C"), Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 16) {
                // Top bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                            .background(.white.opacity(0.18))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("Disponible")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.18))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(.white.opacity(0.3), lineWidth: 0.5))
                }

                // Title
                HStack(spacing: 10) {
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(.white.opacity(0.18))
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Cargo Detail")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.white)
                        Text("#ENV-2024-0421")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }

                // Map placeholder
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.1))
                    .frame(height: 90)
                    .overlay(
                        Label("Monterrey → Bogotá", systemImage: "map")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.6))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white.opacity(0.2), lineWidth: 0.5)
                    )
            }
            .padding(.top, 56)
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Route Detail

struct RouteDetail: View {
    var body: some View {
        DetailCard {
            CardHeader(icon: "location.fill", title: "Ruta", color: .blue)

            HStack(alignment: .top, spacing: 14) {
                // Timeline
                VStack(spacing: 0) {
                    Circle().fill(Color.blue).frame(width: 10, height: 10)
                    Rectangle()
                        .fill(
                            LinearGradient(colors: [.blue, .green],
                                           startPoint: .top, endPoint: .bottom)
                        )
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                    Circle().fill(Color.green).frame(width: 10, height: 10)
                }
                .padding(.top, 4)

                VStack(alignment: .leading, spacing: 0) {
                    routeStop(label: "Origen", place: "Monterrey, Nuevo León")
                    Spacer().frame(height: 16)
                    routeStop(label: "Destino", place: "Bogotá, Colombia")
                }
            }
            .frame(minHeight: 80)

            Divider()

            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                Text("Lunes 21 Abril,")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("8:00 AM")
                    .font(.subheadline.weight(.semibold))
            }
        }
    }

    private func routeStop(label: String, place: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(.secondary)
                .tracking(0.5)
            Text(place)
                .font(.subheadline.weight(.medium))
        }
    }
}

// MARK: - Cargo Description

struct CargoDescription: View {
    var body: some View {
        DetailCard {
            CardHeader(icon: "shippingbox.fill", title: "Información de carga", color: .blue)

            InfoRow(label: "Tipo", value: "Refrigerada", isTag: true)
            InfoRow(label: "Peso", value: "18,000 kg")

            Divider()

            InfoRow(label: "Dimensiones", value: "13 × 2.5 × 2.7 m")

            Divider()

            DescriptionBlock(
                icon: "text.alignleft",
                text: "Contenedor refrigerado con dimensiones estándar. Requiere temperatura controlada durante todo el trayecto."
            )
        }
    }
}

// MARK: - Vehicle Requirements

struct CargoVehicleRequirements: View {
    var body: some View {
        DetailCard {
            CardHeader(icon: "truck.box.fill", title: "Requisitos del vehículo", color: .green)

            InfoRow(label: "Tipo", value: "Tractomula / Furgón")
            InfoRow(label: "Tráiler", value: "10m / 12m / 15m")

            Divider()

            DescriptionBlock(
                icon: "text.alignleft",
                text: "El vehículo debe estar habilitado para carga refrigerada y cumplir con normativas de transporte."
            )
        }
    }
}

// MARK: - Accept CTA

struct AcceptButton: View {
    var body: some View {
        Button {
            // action
        } label: {
            Label("Aceptar carga", systemImage: "plus")
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(.top, 4)
    }
}

// MARK: - Reusable components

struct DetailCard<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            content
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
}

struct CardHeader: View {
    let icon: String
    let title: String
    var color: Color = .blue

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 26, height: 26)
                .background(color.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            Text(title)
                .font(.subheadline.weight(.semibold))
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    var isTag: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            if isTag {
                Text(value)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            } else {
                Text(value)
                    .font(.subheadline.weight(.medium))
            }
        }
    }
}

struct DescriptionBlock: View {
    let icon: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label("Descripción", systemImage: icon)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
        }
    }
}

// MARK: - Color hex helper

extension Color {
    init(hex: String) {
        let v = Int(hex, radix: 16) ?? 0
        self.init(
            red:   Double((v >> 16) & 0xFF) / 255,
            green: Double((v >> 8)  & 0xFF) / 255,
            blue:  Double(v         & 0xFF) / 255
        )
    }
}

#Preview {
    CargoDetailView()
}
