import SwiftUI

struct DriverControlPanel: View {
    let vehicle: any Vehicle
    @State private var isHeaderExpanded = false

    private var factories: [any FactoryQuickInfoCard] {
        [
            TaskFactory(vehicle: vehicle),
            ExpenseFactory(vehicle: vehicle),
            ProtocolFactory(vehicle: vehicle),
            MaintenanceFactory(vehicle: vehicle)
        ]
    }

    var body: some View {
        VStack(spacing: 0) {
            
            VehicleHeader(vehicle: vehicle, isExpanded: $isHeaderExpanded)
            
            QuickActionsGrid()
            
            ScrollView(.vertical) {
                VStack(spacing: 12) {
                    TaskFactory(vehicle: vehicle).make()
                    ExpenseFactory(vehicle: vehicle).make()
                    ProtocolFactory(vehicle: vehicle).make()
                    MaintenanceFactory(vehicle: vehicle).make()
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}


struct VehicleHeader: View {
    let vehicle: any Vehicle
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(spacing: 0) {
            // Contenido del header (colapsado o expandido)
            VStack(alignment: .leading, spacing: 8) {
                // Siempre visible: nombre + ruta
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(vehicle.vehicleInformation.model + " " + vehicle.vehicleInformation.brand)
                            .font(.title.bold())
                        Text(vehicle.vehicleInformation.plate)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    routeButton
                }

                // Solo visible cuando está expandido
                if isExpanded {
                    vehicleImage
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .padding(.horizontal)
            .padding(.top, 54)
            .padding(.bottom, 12)

            // Divider + toggle
            Divider()
            chevronToggle
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .blue.opacity(0.3), radius: 4, y: 2)
    }

    // MARK: Subvistas

    private var routeButton: some View {
        Button {
            // action
        } label: {
            Label("Ver Ruta", systemImage: "location.fill")
                .font(.subheadline.bold())
                .foregroundStyle(.blue)
        }
    }

    private var vehicleImage: some View {
        Image("volvo")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    private var chevronToggle: some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                isExpanded.toggle()
            }
        } label: {
            Image(systemName: "chevron.down")
                .font(.body.bold())
                .foregroundStyle(.secondary)
                .rotationEffect(.degrees(isExpanded ? 180 : 0))
                .padding(.vertical, 6)
        }
    }
}


enum QuickAction: CaseIterable {
    case fuel, phone, alert, scanner, hotel, chat

    var label: String {
        switch self {
        case .fuel:    return "Combustible"
        case .phone:   return "Teléfono"
        case .alert:   return "Alerta"
        case .scanner: return "Escáner"
        case .hotel:   return "Hotel"
        case .chat:    return "Chat"
        }
    }

    var icon: String {
        switch self {
        case .fuel:    return "fuelpump.fill"
        case .phone:   return "phone.fill"
        case .alert:   return "exclamationmark.triangle.fill"
        case .scanner: return "qrcode.viewfinder"
        case .hotel:   return "bed.double.fill"
        case .chat:    return "bubble.left.and.bubble.right.fill"
        }
    }
}

struct QuickActionsGrid: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Acciones rápidas")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(QuickAction.allCases, id: \.self) { action in
                    QuickActionButton(action: action)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
    }
}

private struct QuickActionButton: View {
    let action: QuickAction

    var body: some View {
        Button { } label: {
            VStack(spacing: 8) {
                Image(systemName: action.icon)
                    .font(.title3)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(action.label)
                    .font(.caption.bold())
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 1)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
DriverControlPanel(vehicle: User.mock.vehicles.first!)
}
