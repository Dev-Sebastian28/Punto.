//
//  VehicleProtocol.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation

enum ProtocolImportance: String, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

enum ProtocolTime: String, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly"
    case startingWork = "Starting Work"
    case finishingWork = "Finishing Work"

}

struct VehicleProtocol: Equatable {
    var id: UUID
    var name: String
    var description: String?
    var tasks: [ProtocolTask]
    var importance: ProtocolImportance
    var time: ProtocolTime
    
    func isAvailable(id: UUID) -> Bool {
        guard tasks.count > 0 else {
            return true
        }

        let taskIndex = tasks.firstIndex { ProtocolTask in
            ProtocolTask.id == id
        }

        if tasks[taskIndex! - 1].isCompleted == false {
            return false
        } else {
            return true
        }
    }
}
// cambiar is active
struct ProtocolTask: Equatable {
    let id: UUID
    var taskName: String
    var description: String?
    var isCompleted: Bool
    var isActive: Bool
    
    init(id: UUID = UUID(), taskName: String, description: String? = nil, isCompleted: Bool = false, isActive: Bool = false) {
        self.id = id
        self.taskName = taskName
        self.description = description
        self.isCompleted = isCompleted
        self.isActive = isActive
    }
}
