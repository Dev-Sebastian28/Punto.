//
//  TaskRepository.swift
//  Punto
//
//  Created by Sebastian Garcia on 2/05/26.
//

import Foundation
import Auth
import Supabase

struct TaskRepository {
    let client = SupabaseManagerSingleton.shared.client
    let vehicleId: UUID
    
    init(userId: UUID) {
        self.vehicleId = userId
    }
    
    func save(task: VTask) async throws -> Result<Bool, Error> {
        do {
            // 1. Assign the current user ID and set it to the vehicle just created
            var taskToSave = task
            taskToSave.vehicleId = vehicleId
            
            // 2. Insert to the table with the new userId
            try await client
                .from("v_tasks")
                .insert(taskToSave)
                .execute()
            
            print("✅ Successful saved task")
            return .success(true)
            
        } catch {
            print("❌ Error saving task: \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    func fetchAll() async throws -> [VTask] {
        try await client
            .from("v_tasks")
            .select()
            .eq("user_id", value: "\(vehicleId)")
            .execute()
            .value
    }
}
