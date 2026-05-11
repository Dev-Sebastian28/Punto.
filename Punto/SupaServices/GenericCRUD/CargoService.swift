//
//  CargoService.swift
//  Punto
//
//  Created by Sebastian Garcia on 11/05/26.
//

import Foundation
import Supabase

struct CargoService {

    var userId: UUID

    // MARK: - Dependencies
    let postRequest: SupabaseINSERTRequestProtocol = INSERTRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "cargos"
    )
    let deleteRequest: SupabaseDELETERequestProtocol = DELETErequest(
        table: "cargos",
        client: SupabaseManagerSingleton.shared.client,
        filter: "id"
    )
    let getRequest: SupabaseGETRequestProtocol = GETRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "cargos_public"
    )

    // MARK: - Init
    init(userId: UUID) {
        self.userId = userId
    }

    // MARK: - Methods

    func fetchFeed() async throws -> [Cargo] {
        try await getRequest.fetchItems(model: Cargo.self, itemId: nil, columnName: "id")
    }

    func fetchMyCargos() async throws -> [Cargo] {
        try await getRequest.fetchItems(model: Cargo.self, itemId: userId, columnName: "owner_id")
    }

    func save(_ cargo: Cargo) async throws {
        try await postRequest.insertItem(model: cargo)
    }

    func delete(cargoId: UUID) async throws {
        try await deleteRequest.delateItem(itemId: cargoId)
    }
}
