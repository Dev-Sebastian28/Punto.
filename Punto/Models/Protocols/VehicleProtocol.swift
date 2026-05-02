//
//  VehicleProtocol.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//

import Foundation
import SwiftUI

enum ProtocolImportance: String, Codable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

enum ProtocolTime: String, Codable, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly"
    case startingWork = "Starting Work"
    case finishingWork = "Finishing Work"
}

struct VehicleProtocol: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var description: String?
    var tasks: [ProtocolTask]
    var importance: ProtocolImportance
    var time: ProtocolTime
    var isActive: Bool = true // Movido aquí para activar/desactivar el protocolo completo

    /// Verifica si una tarea específica puede ser editada basándose en el orden secuencial
    func canPerformTask(taskId: UUID) -> Bool {
        guard let currentIndex = tasks.firstIndex(where: { $0.id == taskId }) else {
            return false
        }
        
        // Si es la primera tarea, siempre está disponible
        if currentIndex == 0 { return true }
        
        // La tarea actual solo está disponible si la anterior fue completada
        return tasks[currentIndex - 1].isCompleted
    }
}

struct ProtocolTask: Identifiable, Codable, Equatable {
    let id: UUID
    var taskName: String
    var description: String?
    var isCompleted: Bool
    var order: Int // Añadido para asegurar el orden en la base de datos

    init(id: UUID = UUID(), taskName: String, description: String? = nil, isCompleted: Bool = false, order: Int = 0) {
        self.id = id
        self.taskName = taskName
        self.description = description
        self.isCompleted = isCompleted
        self.order = order
    }
}

extension ProtocolImportance {
    var importanceColor: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .red
        }
    }
}

extension ProtocolTime {
    var timeColor: Color {
        switch self {
        case .daily: return .blue
        case .weekly: return .orange
        case .startingWork: return .red
        case .finishingWork: return .green
        }
    }
}
