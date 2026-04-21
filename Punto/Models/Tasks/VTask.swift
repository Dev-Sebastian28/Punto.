//
//  Task.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation

enum TaskImportance: String, CaseIterable {
    case low, medium, high
}

enum TaskStatus: String, Codable {
    case pending, inProgress, done
}

struct VTask: Identifiable, Hashable {
    let id: UUID
    var title: String
    var description: String?
    var deadLine: Date
    var importance: TaskImportance
    var status: TaskStatus
    
    init(title: String, description: String?, date: Date, importance: TaskImportance, status: TaskStatus = .pending) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.deadLine = date
        self.importance = importance
        self.status = status
    }
}







