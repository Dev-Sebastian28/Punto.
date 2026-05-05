//
//  SupabaseDELEATrequestProtocol.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/05/26.
//

import Foundation
import Supabase

protocol SupabaseDELETERequestProtocol {
    var table: String { get set }
    var client: SupabaseClient { get }
    func customRequest(itemId: UUID) async throws -> Result<Bool, Error>
}

struct DELETErequest: SupabaseDELETERequestProtocol {
    var table: String
    var client: SupabaseClient
    var filter: String
    
    func customRequest(itemId: UUID) async throws -> Result<Bool, Error> {
        do {
            let response = try await client.from(table).delete().eq("id", value: itemId.uuidString).execute()

            guard (200...299).contains(response.status) else {
                return .failure(HttpClientError.invalidStatusCode(response.status, nil))
            }
            
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}
