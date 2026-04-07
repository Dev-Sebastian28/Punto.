//
//   Expense.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation


struct Expense: Codable, Equatable {
    let id: UUID
    let name: String
    let description: String?
    let amount: Double
    let date: Date
    let type: String
    
    init(id: UUID = UUID(), name: String, description: String?, amount: Double, date: Date, type: String) {
        self.id = id
        self.name = name
        self.description = description
        self.amount = amount
        self.date = date
        self.type = type
    }
}




