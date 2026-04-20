//
//  AddVehicleForm.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI
import Foundation

struct AddVehicleForm: View {
    @Environment(\.dismiss) private var dimiss
    @State private var isPrivateSelected = false
    @State private var isTransportSelected = true

    @State private var vehicleInf: VehicleInformation = .init(image: "", plate: "", brand: "", model: "", year: 0, mileage: 0, engine: "", transmission: .automatic, fuel: .diesel)
    
    private var isFormIncomplete: Bool {
        vehicleInf.brand.isEmpty || vehicleInf.plate.isEmpty || vehicleInf.model.isEmpty || vehicleInf.year != 0 || vehicleInf.mileage != 0 || vehicleInf.engine.isEmpty
    }

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            ScrollView {
                vehicleTypeSelector
                formFields
                actionButtons
            }
        }.padding(.horizontal)
    }

    private var vehicleTypeSelector: some View {
        HStack(spacing: 12) {
            VehicleCategoryButton(
                title: "Transport",
                systemImage: "box.truck.fill",
                tint: .orange,
                isSelected: isTransportSelected,
                action: { isTransportSelected = true; isPrivateSelected = false}
            )

            VehicleCategoryButton(
                title: "Private",
                systemImage: "car.fill",
                tint: .blue,
                isSelected: isPrivateSelected,
                action: { isTransportSelected = false; isPrivateSelected = true}
            )
        }
    }

    private var formFields: some View {
        VStack {
            TextFieldComp(
                text: $vehicleInf.brand,
                prompt: "Vehicle Brand, Ex: Toyota, Ford, Volvo",
                image: "line.horizontal.3",
                isRequired: false
            )

            TextFieldComp(
                text: $vehicleInf.model,
                prompt: "Vehicle Model, Ex: Corolla, Mustang, XC90",
                image: "car.rear.fill",
                isRequired: false
            )
            
            TextFieldComp(
                text: $vehicleInf.engine,
                prompt: "Engine Size, Ex: 1.5L, 2.0L",
                image: "engine.combustion.fill",
                isRequired: false
            )

            HStack {
                TextFieldComp(
                    text: $vehicleInf.engine,
                    prompt: "Year, Ex: 2020",
                    image: "calendar",
                    isRequired: false
                )
                
                TextFieldComp(
                    text: $vehicleInf.plate,
                    prompt: "Plate, Ex: ABC-123",
                    image: "rectangle.and.pencil.and.ellipsis",
                    isRequired: false
                )
            }

            vehicleSpecsSection

            TextFieldComp(
                text: $vehicleInf.engine,
                prompt: "Vehicle Mileage",
                image: "gauge.with.dots.needle.50percent",
                isRequired: false
            ).numberKeyboardIfAvailable()
        }
    }

    private var vehicleSpecsSection: some View {
        VStack(spacing: 12) {
            LabeledSegmentedPicker(
                title: "Transmission Type",
                selection: $vehicleInf.transmission
            ) {
                Text("Manual").tag(TransmissionType.manual)
                Text("Automatic").tag(TransmissionType.automatic)
            }

            LabeledSegmentedPicker(
                title: "Fuel Type",
                selection: $vehicleInf.fuel
            ) {
                Text("Gasoline").tag(FuelType.gasoline)
                Text("Diesel").tag(FuelType.diesel)
                Text("Other").tag(FuelType.other)
            }
        }
        .padding(9)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 15))
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
                isEnabled: !isFormIncomplete) {
                    
                }
        }
        .padding(.top)
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
