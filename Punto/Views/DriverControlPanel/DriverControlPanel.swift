import SwiftUI

struct DriverControlPanel: View {
    let vehicle: any Vehicle
    @State private var isHeaderExpanded = false
    
    private var factories: [any FactoryQuickInfoCard] {
        [
            MaintenanceFactory(vehicle: vehicle),
            TaskFactory(vehicle: vehicle),
            ProtocolFactory(vehicle: vehicle),
            ExpenseFactory(vehicle: vehicle)
        ]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            VehicleHeader(vehicle: vehicle, isExpanded: $isHeaderExpanded)
            
            QuickActionsGrid()
            
            ScrollView(.vertical) {
                VStack(spacing: 12) {
                    MaintenanceFactory(vehicle: vehicle).make()
                    ProtocolFactory(vehicle: vehicle).make()
                    TaskFactory(vehicle: vehicle).make()
                    ExpenseFactory(vehicle: vehicle).make()
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
        VStack(alignment: .center, spacing: 2) {
           
            if isExpanded {
                vehicleCard(info: vehicle.vehicleInformation)
                    .transition(.move(edge: .top).combined(with: .opacity))
            } else {
                HStack(alignment: .bottom) {
                    Text(vehicle.vehicleInformation.model + " " + vehicle.vehicleInformation.brand)
                        .font(.title2.bold())
                    
                    Spacer()
                    
                    Text(vehicle.vehicleInformation.plate)
                        .foregroundStyle(.secondary)
                    
                }
            }
            chevronToggle
            
        }
        .padding(.horizontal)
        .padding(.top, 54)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .blue.opacity(0.3), radius: 2, y: 1)
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
    let color: Color = .red
    var body: some View {
        Button { } label: {
            VStack(spacing: 8) {
                Image(systemName: action.icon)
                    .foregroundStyle(color)
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
