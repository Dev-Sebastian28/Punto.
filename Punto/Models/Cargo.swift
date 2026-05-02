//
//  Cargo.swift
//  Punto
//
//  Created by Sebastian Garcia on 22/04/26.
//
import Foundation

import Foundation

enum CargoStatus: String, Codable, CaseIterable {
    case available   // Disponible
    case assigned    // Asignado a un conductor
    case inTransit   // En camino
    case delivered   // Entregado
    case cancelled   // Cancelado
}

struct Cargo: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    
    // Lugares (Podrías usar coordenadas después)
    var origin: String
    var destination: String
    
    // Especificaciones físicas
    var weight: Double        // Cambiado a Double para kilos/libras exactos
    var volume: Double?       // M3 o dimensiones
    var cargoType: String     // Ej: "Refrigerado", "Peligroso"
    
    // Logística y Distancias (en km o millas)
    var distanceToCargo: Double
    var distanceToDestination: Double // Distancia entre origen y destino
    var totalRouteDistance: Double {
        distanceToCargo + distanceToDestination
    }
    
    // Tiempos
    var dueDate: Date         // Cambiado de Int a Date para manejo real de tiempo
    var createdAt: Date = Date()
    
    // Economía y Estado
    var price: Double         // ¿Cuánto paga esta carga?
    var status: CargoStatus = .available
    
    // Información del cliente o notas
    var notes: String?
}
