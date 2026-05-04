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
    func customRequest<T: Codable>(model: T) async throws -> Result<Bool, Error>
}

struct INSERTRequest: SupabaseINSERTRequestProtocol {
    var client: Supabase.SupabaseClient
    var table: String
    func customRequest<T: Codable>(model: T) async throws -> Result<Bool, Error> {
        do {
            let response = try await client
                .from(table)
                .insert(model)
                .execute()
            
            guard (200...299).contains(response.status) else {
                return .failure(HttpClientError.invalidStatusCode(response.status, nil))
            }
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}
