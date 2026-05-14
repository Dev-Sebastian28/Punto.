//
//  AddVehicleViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/04/26.
//
import Foundation
import SwiftUI
import Supabase

private enum Message {
    case success
    case error
    
    var message: String {
        switch self {
        case .success:
            return "Vehicle added successfully"
        case .error:
            return "Something went wrong"
        }
    }
}

@MainActor
@Observable
final class AddVehicleViewModel {
    private(set) var appState: AppState
    
    // MARK: - init
    init(appState: AppState) {
        self.appState = appState
        self.vehicleRepository = VehicleSupaRepository(userId: appState.user.id)
    }
    
    // MARK: - Dependency
    let vehicleRepository: VehicleSupaRepository
    
    
    // MARK: - States:
    var hasVehicle: Bool {
        !appState.user.vehicles.isEmpty
    }
    var vehicles: [Vehicle] {
        appState.user.vehicles
    }
    
    var vehicleCount: String {
        appState.user.vehicles.count.description
    }
    
    var isLoading: Bool = false
    var message: String?
    
    func addVehicle(_ vehicle: Vehicle, imageData: Data?) async  {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            print("DEBUGG: AddVehicleViewModel" + appState.user.id.uuidString)
            print("DEBUGG: AddVehicleViewModel 🔑 user id: \(try? await SupabaseManagerSingleton.shared.client.auth.user().id, default: "ERror")")
            print("DEBUGG: AddVehicleViewModel 🔑 vehicle user_id: \(vehicle.vehicleInformation.userId)")


            try await vehicleRepository.saveVehicle(vehicle.vehicleInformation)
            var finalImageUrl: String? = nil
            
            // Store Vehicle Image in Supabase Buckets
            if let data = imageData {
                let fileName = "\(vehicle.vehicleInformation.plate)_\(UUID().uuidString).jpg"
                finalImageUrl = await vehicleRepository.uploadVehicleImage(data: data, fileName: fileName)
            }
            
            if let data = imageData {
                let fileName = "\(vehicle.vehicleInformation.plate)_\(UUID().uuidString).jpg"
                finalImageUrl = await vehicleRepository.uploadVehicleImage(data: data, fileName: fileName)

                if let url = finalImageUrl {
                    try await vehicleRepository.updateVehicleImageUrl(
                        vehicleId: vehicle.vehicleInformation.id,
                        imageUrl: url
                    )
                }
            }
            
            var infoToSave = vehicle.vehicleInformation
            infoToSave.imageUrl = finalImageUrl
            
            appState.user.vehicles.append(vehicle)
            message = Message.success.message
            
            
            if let index = appState.user.vehicles.firstIndex(where: { $0.vehicleInformation.id == vehicle.vehicleInformation.id }) {
                appState.user.vehicles[index].vehicleInformation.imageUrl = finalImageUrl
            }

        } catch {
            message = Message.error.message

        }
    }
    
    func fetchVehicles() async {
        
        do {
            let vehcilesFetch = try await vehicleRepository.fetchVehicles()
            for vehicle in vehcilesFetch {
                appState.user.vehicles.append(TransportationVehicle(vehicleInformation: vehicle))
            }
            
        } catch {
            print("DEBUGG: AddVehicleViewModel ❌ fetchVehicles failure: \(error)")
            message = Message.error.message

        }
    }
}
