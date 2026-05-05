//
//  TaskRepository.swift
//  Punto
//
//  Created by Sebastian Garcia on 2/05/26.
// Use dependency injection, to the inject it to the view models and make it a Protocol Oriented service (abstract type instead of concrete type) that will allow us to create MOCK service and alter it between production APIs even change from SAAS using dependency injection and dependency inversion principles

import Foundation
import Auth
import Supabase

protocol TaskRepositoryProtocol {
    func save(task: VTask) async throws -> Result<Bool, Error>
    func delete(task: VTask) async throws -> Result<Bool, Error>
    func fetchAll() async throws ->  Result<[VTask], Error>
}

struct TaskRepository:  TaskRepositoryProtocol {
    // MARK: Dependencies:
    let vehicleId: UUID
    let postRequest: SupabaseINSERTRequestProtocol = INSERTRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "v_tasks"
    )
    let deleteRequest: SupabaseDELETERequestProtocol = DELETErequest(
        table: "",
        client: SupabaseManagerSingleton.shared.client,
        filter: "id"
    )
    let getRequest: SupabaseGETRequestProtocol = GETRequest(
        client: SupabaseManagerSingleton.shared.client,
        table: "v_tasks"
    )
        
    
    // MARK: init
    init(userId: UUID) {
        self.vehicleId = userId
    }
    
    func save(task: VTask) async throws -> Result<Bool, Error> {
         await postRequest.customRequest(model: task)
    }
    
    func delete(task: VTask) async throws -> Result<Bool, Error> {
        try await deleteRequest.customRequest(itemId: task.id)
    }
    
    func fetchAll() async throws ->  Result<[VTask], Error> {
         await getRequest.customRequest(model: VTask.self, vehicleId: vehicleId)
    }
}

struct MockTaskRepository: TaskRepositoryProtocol {
    func delete(task: VTask) async throws -> Result<Bool, any Error> {
        return .success(true)
    }
    
    func fetchAll() async throws -> Result<[VTask], any Error> {
        return .success([VTask].dummyData())

    }
    
    func save(task: VTask) async throws -> Result<Bool, Error> {
        return .success(true)
    }
}



