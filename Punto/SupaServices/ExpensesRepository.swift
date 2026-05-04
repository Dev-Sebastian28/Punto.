//
//  ExpensesRepository.swift
//  Punto
//
//  Created by Sebastian Garcia on 2/05/26.
//

import Foundation
import Supabase
import Auth

struct ExpensesRepository {
    let client = SupabaseManagerSingleton.shared.client
    let userId: UUID
    
    init(userId: UUID) {
        self.userId = userId
    }
    
    func saveExpense(expense: Expense) async throws {
        do {
            // 1. Assign the current user ID and set it to the vehicle just created
            var expenseToSave = expense
            expenseToSave.userId = userId
            
            // 2. Insert to the table with the new userId
            try await client
                .from("vehicles")
                .insert(expenseToSave)
                .execute()
            
            print("✅ Successful saved expense")
        }
    }
    
    func fetchExpenses() async throws -> [Expense] {
       try await client
          .from("instruments")
          .select()
          .eq("user_id", value: userId.uuidString)
          .execute()
          .value

    }
}
