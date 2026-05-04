//
//  SupabaseGETRequestProtocol 2.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/05/26.
//
import Foundation
import Supabase

protocol SupabaseGETRequestProtocol {
    var client: SupabaseClient { get }
    var table: String { get }
    func customRequest<T: Decodable>(model: T.Type, vehicleId: UUID) async throws -> Result<[T], Error>
}

struct GETRequest: SupabaseGETRequestProtocol {
    let client: SupabaseClient
    let table: String
    
    @MainActor
    func customRequest<T: Decodable>(model: T.Type, vehicleId: UUID) async throws -> Result<[T], Error> {
        do {
            let response = try await client
                .from(table)
                .select()
                .eq("vehicle_id", value: vehicleId)
                .execute()
            
            guard (200...299).contains(response.status) else {
                let bodyString = String(data: response.data, encoding: .utf8)
                print(bodyString ?? "")
                return .failure(HttpClientError.invalidStatusCode(response.status, nil))
            }
            
            let decodedItems = try DataArrayDecoder.map(T.self, from: response.data)
            return .success(decodedItems)
        } catch {
            return .failure(error)
        }
    }
}


