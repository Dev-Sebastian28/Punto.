//
//  AppState.swift
//  Punto
//
//  Created by Sebastian Garcia on 14/04/26.
//
import Foundation
import Auth
import Supabase

@Observable
final class AppState {
    var user: User = .empty {
        willSet {
            print("DEBUG AppState: " + "User Change from: \(user)")
            print("------------------------------------------------------------------------------------------------")
            print("DEBUG AppState: " + "User Change to: \(newValue)")
        }
    }
    
//    func fetchData() async {
//        do {
//            let vehicles = try await VehicleSupaRepository(userId: user.id).fetchVehicles()
//
//            let loadedVehicles: [Vehicle] = try await withThrowingTaskGroup(of: Vehicle?.self) { group in
//                for vehicle in vehicles {
//                    group.addTask {
//                        do {
//                            let transportVehicle = TransportationVehicle(vehicleInformation: vehicle)
//                            transportVehicle.tasks = try await TaskRepository(vehicleId: vehicle.id).fetchAll()
//                            return transportVehicle
//                        } catch {
//                            print("AppState: Error loading vehicle \(vehicle.id): \(error)")
//                            return nil  // falla silenciosa por vehicle, no cancela el grupo
//                        }
//                    }
//                }
//
//                // Recolectar resultados de forma segura
//                var results: [Vehicle] = []
//                for try await vehicle in group {
//                    if let vehicle { results.append(vehicle) }
//                }
//                return results
//            }
//
//            user.vehicles = loadedVehicles  // asignación única al final, sin race condition
//
//        } catch {
//            print("AppState: fetchData failed: \(error)")
//        }
//    }
    
    
    // MARK: - Init and Deinit:
    init() {
        print("👋 init: AppState")
        print("DEBUG AppState: " + user.id.uuidString)
    }
    
    deinit {
        print(" 👋 deinit: AppState")
    }
}


