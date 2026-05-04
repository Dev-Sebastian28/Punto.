//
//   Expense.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation
import SwiftUI

struct Expense: Codable, Identifiable {
    let id: UUID
    var userId: UUID?
    var name: String
    var description: String?
    var amount: Double
    var date: Date
    var type: String
    
    init(id: UUID = UUID(), name: String, description: String?, amount: Double, date: Date, type: String) {
        self.id = id
        self.name = name
        self.description = description
        self.amount = amount
        self.date = date
        self.type = type
    }
}

extension Expense {
    var typColor: Color {
        switch type {
        case "Food":
            return .red
        case "Transport":
            return .blue
        case "Other":
            return .yellow
        default:
            return .gray
        }
    }
    
    var dominatColor: Color {
        if amount < 0 {
            return .red
        } else {
            return .green
        }
    }
}




