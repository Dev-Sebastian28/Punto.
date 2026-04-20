//
//  AddVehicleForm.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct AddVehicleForm: View {
    @Environment(\.dismiss) private var dimiss
    @State private var isPrivateSelected = false
    @State private var isTransportSelected = true

    @State private var brand = ""
    @State private var plate = ""
    @State private var model = ""
    @State private var year = ""
    @State private var mileage = ""
    @State private var engine = ""
    @State private var transmission: TransmissionType = .automatic
    @State private var fuel: FuelType = .gasoline
    @State private var userExample = User(name: "", email: "", access: .admin, country: .argentina)

    private var isFormIncomplete: Bool {
        brand.isEmpty || plate.isEmpty || model.isEmpty || year.isEmpty || mileage.isEmpty || engine.isEmpty
    }

    var body: some View {
        VStack(spacing: 16) {
            vehicleTypeSelector
            formFields
            actionButtons
        }.padding(.horizontal)
    }

    private var vehicleTypeSelector: some View {
        HStack(spacing: 12) {
            VehicleCategoryButton(
                title: "Transport",
                systemImage: "box.truck.fill",
                tint: .orange,
                isSelected: isTransportSelected,
                action: selectTransport
            )

            Spacer()

            VehicleCategoryButton(
                title: "Private",
                systemImage: "car.fill",
                tint: .blue,
                isSelected: isPrivateSelected,
                action: selectPrivate
            )
        }
        .padding(.horizontal)
    }

    private var formFields: some View {
        VStack {
            TextFieldComp(
                text: $brand,
                prompt: "Vehicle Brand, Ex: Toyota, Ford, Volvo",
                image: "",
                isRequired: false
            )

            TextFieldComp(
                text: $model,
                prompt: "Vehicle Model, Ex: Corolla, Mustang, XC90",
                image: "car.rear.fill",
                isRequired: false
            )
            
            TextFieldComp(
                text: $engine,
                prompt: "Engine Size, Ex: 1.5L, 2.0L",
                image: "engine.combustion.fill",
                isRequired: false
            )

            TextFieldComp(
                text: $year,
                prompt: "Year, Ex: 2020",
                image: "calendar",
                isRequired: false
            )
            
            TextFieldComp(
                text: $plate,
                prompt: "Plate, Ex: ABC-1234",
                image: "rectangle.and.pencil.and.ellipsis",
                isRequired: false
            )

            vehicleSpecsSection

            TextFieldComp(
                text: $mileage,
                prompt: "Vehicle Mileage",
                image: "gauge.with.dots.needle.50percent",
                isRequired: false
            )
            .numberKeyboardIfAvailable()
        }
    }

    private var vehicleSpecsSection: some View {
        VStack(spacing: 12) {
            LabeledSegmentedPicker(
                title: "Transmission Type",
                selection: $transmission
            ) {
                Text("Manual").tag(TransmissionType.manual)
                Text("Automatic").tag(TransmissionType.automatic)
            }

            LabeledSegmentedPicker(
                title: "Fuel Type",
                selection: $fuel
            ) {
                Text("Gasoline").tag(FuelType.gasoline)
                Text("Diesel").tag(FuelType.diesel)
                Text("Other").tag(FuelType.other)
            }
        }
        .padding(9)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }

    private var actionButtons: some View {
        HStack(spacing: 16) {
            DButtonComp(
                text: "Cancel",
                color: .gray,
                image: nil,
                style: .neutral,
                maxWidth: 100
            ) {
                dimiss()
            }

            DButtonComp(
                text: "Add Vehicle",
                color: .blue,
                image: "car.fill",
                maxWidth: 150,
                isEnabled: !isFormIncomplete,
                action: addVehicle
            )
        }
        .padding(.top)
    }

    private func selectTransport() {
        isTransportSelected.toggle()
        isPrivateSelected = false
    }

    private func selectPrivate() {
        isPrivateSelected.toggle()
        isTransportSelected = false
    }

    private func addVehicle() {
        let info = VehicleInformation(
            id: .init(),
            image: "volvo",
            plate: plate,
            brand: brand,
            model: model,
            year: Int(year) ?? 0,
            mileage: Int(mileage) ?? 0,
            engine: engine,
            transmission: transmission,
            fuel: fuel
        )

        if isTransportSelected {
            userExample.vehicles.append(TransportationVehicle(vehicleInformation: info))
        } else {
            userExample.vehicles.append(PrivateVehicle(vehicleInformation: info))
        }
    }
}

private struct VehicleCategoryButton: View {
    let title: String
    let systemImage: String
    let tint: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundStyle(tint)
                    .frame(width: 40, height: 40)
                    .background(tint.opacity(0.1))
                    .clipShape(Circle())

                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(isSelected ? tint.opacity(0.2) : Color.platformSecondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}



#Preview {
    AddVehicleForm()
}
