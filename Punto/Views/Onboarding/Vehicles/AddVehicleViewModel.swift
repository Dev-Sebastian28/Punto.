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

@Observable
final class AddVehicleViewModel {
    private(set) var user: User
    
    // MARK: - init
    init(appState: AppState) {
        self.user = appState.user
        self.vehicleRepository = VehicleSupaRepository(appState: appState)
    }
    
    // MARK: - Dependency
    let vehicleRepository: VehicleSupaRepository
    
    
    // MARK: - States:
    var hasVehicle: Bool {
        !user.vehicles.isEmpty
    }
    var vehicles: [Vehicle] {
        user.vehicles
    }
    
    var vehicleCount: String {
        user.vehicles.count.description
    }
    
    var isLoading: Bool = false
    var message: String?
    
    func addVehicle(_ vehicle: Vehicle, imageData: Data?) async  {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        
        
        let result = try? await vehicleRepository.saveVehicle(vehicle.vehicleInformation)
        print(user.id)
        print("🔑 user id: \(try? await SupabaseManagerSingleton.shared.client.auth.user().id, default: "ERror")")
        print("🔑 vehicle user_id: \(vehicle.vehicleInformation.userId)")

        switch result {
        case .success(_):
            
            var finalImageUrl: String? = nil
            
            // Store Vehicle Image in Supabase Buckets
            if let data = imageData {
                let fileName = "\(vehicle.vehicleInformation.plate)_\(UUID().uuidString).jpg"
                finalImageUrl = await vehicleRepository.uploadVehicleImage(data: data, fileName: fileName)
            }
            var infoToSave = vehicle.vehicleInformation
            infoToSave.imageUrl = finalImageUrl
            
            user.vehicles.append(vehicle)
            message = Message.success.message
            
            
            if let index = user.vehicles.firstIndex(where: { $0.vehicleInformation.id == vehicle.vehicleInformation.id }) {
                user.vehicles[index].vehicleInformation.imageUrl = finalImageUrl
            }
            break
        case .failure(let error):
            print("❌ saveVehicle failure: \(error)")
            message = Message.error.message
            
        case .none:

            message = Message.error.message
        }
    }
    
    func fetchVehicles() async {
        let result = try? await vehicleRepository.fetchVehicles()
        
        switch result {
        case .success(let success):
            for vehicle in success {
                user.vehicles.append(TransportationVehicle(vehicleInformation: vehicle))
            }
            print(success)
        case .failure(let error):
            print("❌ fetchVehicles failure: \(error)")
            message = Message.error.message
        case .none:
            message = Message.error.message
        }
    }
    
    
}
