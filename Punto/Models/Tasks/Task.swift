//
//  Task.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation

enum TaskImportance: String, Codable {
    case low, medium, high
}

enum TaskStatus: String, Codable {
    case pending, inProgress, done
}

struct Task {
    let id: UUID = UUID()
    var title: String
    var description: String
    var date: Date
    var importance: TaskImportance
    var status: TaskStatus
}





