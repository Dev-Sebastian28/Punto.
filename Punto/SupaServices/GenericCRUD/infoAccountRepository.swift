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
    
    
    func save(_ userInfo: UserInformation) async throws  {
        try await postRequest.insertItem(model: userInfo)
    }
    
    func delete(id userId: UUID) async throws {
        try await deleteRequest.delateItem(itemId: userId)
    }
    
    func fetchAll(id userId: UUID) async throws -> UserInformation {
        try await getRequest.fetchItem(model: UserInformation.self, itemId: userId)
    }
}
