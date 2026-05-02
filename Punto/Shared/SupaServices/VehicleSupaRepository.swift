
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
    
    func saveVehicle(_ vehicle: VehicleInformation) async throws {
            do {
                // 1. Check the current user status (may not be authenticated)
                guard let currentUser = try? await client.auth.session.user else {
                    print("❌ No session found (login or register required) ")
                    return
                }
                
                // 2. Assign the current user ID and set it to the vehicle just created
                var vehicleToSave = vehicle
                vehicleToSave.userId = currentUser.id
                
                // 3. Insert to the table with the new userId
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
}
