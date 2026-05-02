//
//  AddVehicleViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/04/26.
//
import Foundation
import SwiftUI

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
    
    // MARK: - Dependency
    let vehicleRepository = VehicleSupaRepository()
    
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
    
    func addVehicle(_ vehicle: Vehicle, imageData: Data?) async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            var finalImageUrl: String? = nil
            
            if let data = imageData {
                let fileName = "\(vehicle.vehicleInformation.plate)_\(UUID().uuidString).jpg"
                finalImageUrl = await vehicleRepository.uploadVehicleImage(data: data, fileName: fileName)
            }
            
            var infoToSave = vehicle.vehicleInformation
            infoToSave.imageUrl = finalImageUrl
            
            try await vehicleRepository.saveVehicle(infoToSave)
            
            user.vehicles.append(vehicle)
            message = Message.success.message
            
            if let index = user.vehicles.firstIndex(where: { $0.vehicleInformation.id == vehicle.vehicleInformation.id }) {
                user.vehicles[index].vehicleInformation.imageUrl = finalImageUrl
            }
            
        } catch {
            print("Error al guardar el vehículo: \(error)")
            message = Message.error.message
        }
    }
    
    init(user: User) {
        self.user = user
    }
}
