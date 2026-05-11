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
    func fetchItems<T: Decodable>(model: T.Type, itemId: UUID?, columnName: String) async throws -> [T]
    func fetchItem<T: Decodable>(model: T.Type, itemId: UUID?, columnName: String) async throws -> T

}

struct GETRequest: SupabaseGETRequestProtocol {
    let client: SupabaseClient
    let table: String
    
    @MainActor
    func fetchItems<T: Decodable>(model: T.Type, itemId: UUID?, columnName: String) async throws -> [T] {
        if let itemId = itemId {
            let response = try await client
                .from(table)
                .select()
                .eq(columnName, value: itemId)
                .execute()
            
            guard (200...299).contains(response.status) else {
                let bodyString = String(data: response.data, encoding: .utf8)
                print(bodyString ?? "")
                throw (HttpClientError.invalidStatusCode(response.status, nil))
            }
            
            let decodedItems = try DataArrayDecoder.map(T.self, from: response.data)
            return decodedItems

            
        } else {
            let response = try await client
                .from(table)
                .select()
                .execute()
            
            guard (200...299).contains(response.status) else {
                let bodyString = String(data: response.data, encoding: .utf8)
                print(bodyString ?? "")
                throw (HttpClientError.invalidStatusCode(response.status, nil))
            }
            let decodedItems = try DataArrayDecoder.map(T.self, from: response.data)
            return decodedItems

        }
    }
    
    func fetchItem<T: Decodable>(model: T.Type, itemId: UUID?, columnName: String) async throws -> T {
        let response = try await client
            .from(table)
            .select()
            .eq(columnName, value: itemId)
            .execute()
        
        guard (200...299).contains(response.status) else {
            let bodyString = String(data: response.data, encoding: .utf8)
            print(bodyString ?? "")
            throw (HttpClientError.invalidStatusCode(response.status, nil))
        }
        
        let decodedItem = try SingleDataDecoder.map(T.self, from: response.data)
        return decodedItem
    }
}

