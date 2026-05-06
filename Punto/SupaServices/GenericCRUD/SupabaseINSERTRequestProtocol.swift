//
//  SupabaseINSERTRequestProtocol.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/05/26.
//
import Foundation
import Supabase

protocol SupabaseINSERTRequestProtocol {
    var table: String { get set }
    var client: SupabaseClient { get }
    func insertItem<T: Encodable>(model: T) async throws
}

struct INSERTRequest: SupabaseINSERTRequestProtocol {
    var client: Supabase.SupabaseClient
    var table: String
    func insertItem<T: Encodable>(model: T) async throws  {
            
            let response = try await client
                .from(table)
                .insert(model)
                .execute()
            
            guard (200...299).contains(response.status) else {
                print("Debbug: INSERTRequest" + "Server error: \(response.status)")
                throw (HttpClientError.invalidStatusCode(response.status, nil))
            }
    }
}
