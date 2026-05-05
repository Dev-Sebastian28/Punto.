
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
    
    // MARK: init:
    init(appState: AppState) {
        self.userId = appState.user.id
    }
    
    var userId: UUID
    
    
    func saveVehicle(_ vehicle: VehicleInformation) async throws -> Result<Bool, Error> {
         await postRequest.customRequest(model: vehicle)
    }
    
    func fetchVehicles() async throws -> Result<[VehicleInformation], Error>  {
        print("statr fetching")
        return await getRequest.customRequest(model: VehicleInformation.self, vehicleId: userId)
    }
    
    func deleteVehicle(for vehicle: VehicleInformation) async throws -> Result<Bool, Error> {
        try await deleteRequest.customRequest(itemId: vehicle.id)
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
    
    
}
