//
//  SupaRepositoryProtocol.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/05/26.
//
import Foundation
import Supabase

protocol SupaRepositoryProtocol {
    var client: SupabaseClient { get }
    var table: String { get }
    
    func insert<T: Codable>(_ model: T, vehicleId: UUID) async throws -> Result<Bool, Error>
    func delete<T: Codable & Identifiable>(_ model: T, vehicleId: UUID) async throws -> Result<Bool, Error>
    func update<T: Codable & Identifiable>(_ model: T, vehicleId: UUID) async throws -> Result<Bool, Error>
    
    func getAll<T: Codable>(vehicleId: UUID) async throws -> Result<[T], Error>
}
