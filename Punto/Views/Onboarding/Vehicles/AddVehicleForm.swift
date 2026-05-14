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
    @State private var vehicleInf: VehicleInformation = .empty
    
    // MARK: Vehicle Picture Properties
    @State private var pickerItem: PhotosPickerItem?
    @State private var uiImage: UIImage?
    @State private var selectedImageData: Data?
    
    @Environment(AppCoordinator.self) var coordinator
    
    let vm: AddVehicleViewModel
    let userId: UUID
    let mode: VehicleType
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            ScrollView {
                imagePicker
                    .padding(.bottom)
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
                coordinator.onBoardingCoordinator.addVehicleCoordinator.didCancel()

            }
            
            DButtonComp(
                text: "Add Vehicle",
                color: .blue,
                image: "car.fill",
                maxWidth: 150) {
                    vehicleInf.userId = userId
                    print("Debug: AddVehicleForm: vehicleInf:" + "\(vehicleInf)")
                    Task {
                        switch mode {
                            
                        case .transportVehicle:
                            await vm.addVehicle(
                                TransportationVehicle(
                                    vehicleInformation: vehicleInf
                                ),
                                imageData: selectedImageData
                            )
                        case .privateVehicle:
                            await vm.addVehicle(
                                PrivateVehicle(
                                    vehicleInformation: vehicleInf
                                ),
                                imageData: selectedImageData
                            )
                        }
                    }
                    coordinator.onBoardingCoordinator.addVehicleCoordinator.didCancel()
                }
        }.padding(.top)
    }
}

#Preview {
    AddVehicleForm(
        vm: AddVehicleViewModel(appState: AppState()), userId: UUID(), mode: .privateVehicle
    ).environment(AppCoordinator(appState: AppState()))
}
