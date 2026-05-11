//
//  infoAccountRepository.swift
//  Punto
//
//  Created by Sebastian Garcia on 5/05/26.
//

import Foundation
import Supabase

struct infoAccountRepository {
    
    var userId: UUID
   
    // MARK: -  Dependencies:
    let postRequest: SupabaseINSERTRequestProtocol = INSERTRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "user_information"
    )
    let deleteRequest: SupabaseDELETERequestProtocol = DELETErequest(
        table: "user_information",
        client: SupabaseManagerSingleton.shared.client,
        filter: "id"
    )
    let getRequest: SupabaseGETRequestProtocol = GETRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "user_information"
    )
    
    
    // MARK: - init
    init(userId: UUID) {
        self.userId = userId
    }
    
    
    func save(_ userInfo: UserProfile) async throws  {
        try await postRequest.insertItem(model: userInfo)
    }
    
    func delete(id userId: UUID) async throws {
        try await deleteRequest.delateItem(itemId: userId)
    }
    
    func fetchAll(id userId: UUID) async throws -> UserProfile {
        try await getRequest.fetchItem(model: UserProfile.self, itemId: userId, columnName: "user_id")
    }
}
