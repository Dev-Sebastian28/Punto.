import SwiftUI

struct SelectVehicleTypeView: View {
    let coordinator: AddVehicleCoordinator

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            header
            VehicleCategoryButton(
                systemImages: ["box.truck.fill", "truck.pickup.side.fill", "shippingbox.fill"],
                title: "Transport",
                description: "Heavy-duty trucks, tractor-trailers, and commercial freight vehicles.",
                advice: "Required to use the Cargo feature",
                tint: .orange
            ) {
                coordinator.didSelectVehicleType(.transportVehicle)
            }

            VehicleCategoryButton(
                systemImages: ["car.fill", "suv.side.rear.open.fill", "convertible.side.fill"],
                title: "Private",
                description: "Personal cars, SUVs, and daily-use vehicles for individual or family travel.",
                advice: "All features except Cargo",
                tint: .blue
            ) {
                coordinator.didSelectVehicleType(.privateVehicle)
            }
            


            Spacer()
        }
        .padding()
        .background(Color.platformGroupedBackground.ignoresSafeArea())
        .navigationBarBackButtonHidden()
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Vehicle type")
                .font(.largeTitle.weight(.bold))
            Text("Select the type that best describes your vehicle")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

struct VehicleCategoryButton: View {
    let systemImages: [String]
    let title: String
    let description: String
    let advice: String
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 10) {
                    Spacer()
                    ForEach(systemImages, id: \.self) { name in
                        Image(systemName: name)
                            .font(.body.weight(.medium))
                            .foregroundStyle(tint)
                            .frame(width: 38, height: 38)
                            .background(tint.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Spacer()
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(tint)
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                HStack(alignment: .center, spacing: 8) {
                    
                    Image(systemName: "info.circle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(advice)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }.genericRoundedBackground(color: Color.platformGroupedBackground)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.platformSystemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(tint.opacity(0.2), lineWidth: 1)
            }
        }.buttonStyle(.plain)
    }
}

#Preview {
    SelectVehicleTypeView(coordinator: AddVehicleCoordinator(appState: AppState()))
}
