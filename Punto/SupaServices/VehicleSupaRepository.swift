
//
//  VehicleRepository.swift
//  Punto
//
//  Created by Sebastian Garcia on 29/04/26.
//

import Supabase
import SwiftUI

class VehicleSupaRepository {
    let client = SupabaseManagerSingleton.shared.client
    let userId: UUID
    
    init(userId: UUID) {
        self.userId = userId
    }
    
    func saveVehicle(_ vehicle: VehicleInformation) async throws {
            do {
                
                // 1. Assign the current user ID and set it to the vehicle just created
                var vehicleToSave = vehicle
                vehicleToSave.userId = userId
                
                // 2. Insert to the table with the new userId
                try await client
                    .from("vehicles")
                    .insert(vehicleToSave)
                    .execute()
                
                print("✅ Successful saved vehicle ")
                
            } catch {
                print("❌ Save vehicle error: \(error.localizedDescription)")
                throw error 
            }
        }
    
    func uploadVehicleImage(data: Data, fileName: String) async -> String? {
        do {
            // reference to the supabase bucket called "vehicle_images"
            let storage = client.storage.from("vehicle_images")
            
            // 1. upload the file to supa Bucket
            try await storage.upload(
                fileName,
                data: data,
                options: FileOptions(contentType: "image/jpeg")
            )
            
            // 2. Obtenemos la URL pública para guardarla en la tabla
            let url = try storage.getPublicURL(path: fileName)
            return url.absoluteString
            
        } catch {
            print("❌ Image upload error: \(error)")
            return nil
        }
    }
    
    func fetchVehicles() async throws -> [VehicleInformation] {
        do {
            guard let currentUser = try? await client.auth.session.user else {
                print("❌ No session found (login or register required) ")
                return []
            }

            try await client
                .from("vehicles")
                .select()
                .eq("user_id", value: "\(currentUser.id)")
                .execute()
                .value
        } catch {
            print("error: \(error)")
        }
        return []
    }
}
