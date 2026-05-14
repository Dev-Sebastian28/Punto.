
//
//  VehicleRepository.swift
//  Punto
//
//  Created by Sebastian Garcia on 29/04/26.
//

import Supabase
import SwiftUI

class VehicleSupaRepository {
    // MARK: Dependencies:
    let postRequest: SupabaseINSERTRequestProtocol = INSERTRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "vehicles"
    )
    let deleteRequest: SupabaseDELETERequestProtocol = DELETErequest(
        table: "",
        client: SupabaseManagerSingleton.shared.client,
        filter: "user_id"
    )
    let getRequest: SupabaseGETRequestProtocol = GETRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "vehicles"
    )
    
    // MARK: - init
    init(userId: UUID) {
        self.userId = userId
    }
    
    var userId: UUID
    
    
    func saveVehicle(_ vehicle: VehicleInformation) async throws  {
         try await postRequest.insertItem(model: vehicle)
    }
    
    func fetchVehicles() async throws -> [VehicleInformation] {
        return try await getRequest.fetchItems(model: VehicleInformation.self, itemId: userId, columnName: "user_id")
    }
    
    func deleteVehicle(for vehicle: VehicleInformation) async throws  {
        try await deleteRequest.delateItem(itemId: vehicle.id)
    }
    
    // MARK: Todo
    func uploadVehicleImage(data: Data, fileName: String) async -> String? {
        do {
            // reference to the supabase bucket called "vehicle_images"
            let storage = SupabaseManagerSingleton.shared.client.storage.from("vehicle_images")
            
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
    
    func updateVehicleImageUrl(vehicleId: UUID, imageUrl: String) async throws {
        try await SupabaseManagerSingleton.shared.client
            .from("vehicles")
            .update(["image_url": imageUrl])
            .eq("id", value: vehicleId)
            .execute()
    }
}
