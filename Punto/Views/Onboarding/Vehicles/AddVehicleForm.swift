//
//  AddVehicleForm.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI
import PhotosUI
import UIKit

struct AddVehicleForm: View {
    @State private var isPrivateSelected = false
    @State private var isTransportSelected = true
    @State private var vehicleInf: VehicleInformation = .init(
        imageUrl: nil,
        plate: "",
        brand: "",
        model: "",
        year: 0,
        mileage: 0,
        engine: "",
        transmission: .automatic,
        fuel: .diesel
    )
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var uiImage: UIImage?
    @State private var selectedImageData: Data?
    
    let vm: AddVehicleViewModel
    
    @Environment(\.dismiss) private var dimiss
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            ScrollView {
                imagePicker
                vehicleTypeSelector
                formFields
                actionButtons
            }
        }
        .padding(.horizontal)
        .onChange(of: pickerItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data),
                   let compressedData = image.jpegData(compressionQuality: 0.5) {
                    selectedImageData = compressedData
                    uiImage = image
                }
            }
        }
    }
    
    private var imagePicker: some View {
        VStack {
            PhotosPicker(selection: $pickerItem, matching: .images) {
                if let uiImage = uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Label("Select a vehicle image", systemImage: "photo")
                        .frame(maxWidth: .infinity, minHeight: 200)
                        .background(Color.gray.opacity(0.1))
                }
            }
        }.clipShape(RoundedRectangle(cornerRadius: 10))
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
                text: $vehicleInf.model,
                prompt: "Vehicle Brand, Ex: Kenworth, Volvo",
                leadingIcon: "line.horizontal.3",
                color: .gray,
                autocapitalization: .words
            )
            
            TextFieldComp(
                text: $vehicleInf.brand,
                prompt: "Vehicle Model, Ex: Corolla, Mustang, XC90",
                leadingIcon: "car.rear.fill",
                color: .gray,
                autocapitalization: .words
            )
            
            TextFieldComp(
                text: $vehicleInf.engine,
                prompt: "Engine Size, Ex: 1.5L, 2.0L",
                leadingIcon: "engine.combustion.fill",
                color: .gray,
                autocapitalization: .words
            )
            
            HStack {
                TextFieldComp(
                    intValue: $vehicleInf.year,
                    prompt: "Year, Ex: 2020",
                    leadingIcon: "calendar"
                )
                
                TextFieldComp(
                    text: $vehicleInf.plate,
                    prompt: "Plate, Ex: ABC-123",
                    leadingIcon: "rectangle.and.pencil.and.ellipsis"
                )
            }
            
            vehicleSpecsSection
            
            
            TextFieldComp(
                intValue: $vehicleInf.mileage,
                prompt: "Vehicle Mileage",
                leadingIcon: "gauge.with.dots.needle.50percent"
            )
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
                maxWidth: 150) {
                    Task {
                        if isTransportSelected {
                            await vm.addVehicle(TransportationVehicle(vehicleInformation: vehicleInf), imageData: selectedImageData)
                            
                        } else {
                            await vm.addVehicle(TransportationVehicle(vehicleInformation: vehicleInf), imageData: selectedImageData)
                        }
                    }
                    
                    dimiss()
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
    AddVehicleForm(vm: AddVehicleViewModel(user: .mock))
}
