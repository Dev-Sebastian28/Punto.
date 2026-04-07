//
//  VehicleProtocol.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation

enum VehicleProtocolImportance: String, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

enum ProtocolTime: String, Codable {
    case daily = "Daily"
    case weekly = "Weekly"
    case startingWork = "Starting Work"
    case finishingWork = "Finishing Work"

}


struct VehicleProtocol {
    let id: UUID
    let name: String
    let description: String?
    let tasks: [ProtocolTask]
    let importance: VehicleProtocolImportance
    let time: ProtocolTime
}


struct LinearVehicleProtocol {
    let id: UUID
    let name: String
    let description: String?
    let tasks: [ProtocolTask]
    let importance: VehicleProtocolImportance
    
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

struct ProtocolTask {
    let id: UUID
    let task: String
    let description: String?
    var isCompleted: Bool
    let isActive: Bool
}
