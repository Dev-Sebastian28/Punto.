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
    func delateItem(itemId: UUID) async throws
}

struct DELETErequest: SupabaseDELETERequestProtocol {
    var table: String
    var client: SupabaseClient
    var filter: String
    
    func delateItem(itemId: UUID) async throws  {
            let response = try await client.from(table).delete().eq("id", value: itemId.uuidString).execute()

            guard (200...299).contains(response.status) else {
                throw (HttpClientError.invalidStatusCode(response.status, nil))
            }
        
    }
}
