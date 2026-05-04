//
//  MaintenanceItemDTO.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/04/26.
//
import Foundation

// Name DTO (Data Transfer Object) to every objet fetched externaly not bussines model objetcs
struct VehiclePartDTO: Codable {
    let partName: String
    let category: String
    let intervalType: String 
    let kmFixed: Int?
    let kmMin: Int?
    let kmMax: Int?
    let months: Int?

    enum CodingKeys: String, CodingKey {
        case partName      = "part_name"
        case category      = "category"
        case intervalType  = "interval_type"
        case kmFixed       = "km_fixed"
        case kmMin         = "km_min"
        case kmMax         = "km_max"
        case months        = "months"
    }
}


struct VehiclePartWrapper: Identifiable {
    let vehiclePart: VehiclePartDTO
    let id: UUID
    var userId: UUID?
    
    // Last mainteined Info
    let lastMaintenanceDate: Date
    let lastMaintenanceUnity: Int
    
    // Current Unity
    let currentUnity: Int

}

extension VehiclePartDTO {
    var systemImage: String {
        switch category {
        case "fluids":      return "drop.fill"
        case "filters":     return "line.3.horizontal.decrease.circle.fill"
        case "brakes":      return "circle.circle.fill"
        case "belts":       return "arrow.triangle.2.circlepath"
        case "electrical":  return "bolt.fill"
        case "suspension":  return "car.fill"
        case "tires":       return "circle.dotted"
        default:            return "wrench.and.screwdriver.fill"
        }
    }
}
