//
//  Task.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation
import SwiftUI

enum TaskImportance: String, Codable, CaseIterable {
    case low, medium, high
}

enum TaskStatus: String, Codable, CaseIterable {
    case pending, inProgress, done
}

struct VTask: Codable ,Identifiable, Hashable {
    var id: UUID
    var title: String
    var description: String?
    var deadLine: Date
    //var destination: String? = nil
    var importance: TaskImportance
    var status: TaskStatus

}


extension TaskImportance {
    var color: Color {
        switch self {
        case .low:    return .green
        case .medium: return .blue
        case .high:   return .red
        }
    }
}


extension TaskStatus {
    var color: Color {
        switch self {
        case .pending:    return .green
        case .inProgress: return .orange
        case .done:       return .blue
        }
    }
}


