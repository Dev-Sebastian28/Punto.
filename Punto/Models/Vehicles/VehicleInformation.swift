//
//  VehicleInfo.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//
import Foundation
import SwiftUI

enum TransmissionType: String, Codable {
    case manual = "manual"
    case automatic = "automatic"
}

enum FuelType: String, Codable {
    case diesel = "diesel"
    case gasoline = "gasoline"
    case other = "other"
}

struct VehicleInformation: Identifiable, Codable {
    var id: UUID = UUID()
    var userId: UUID
    var imageUrl: String?
    var plate: String
    var brand: String
    var model: String
    var year: Int
    var mileage: Int
    var engine: String
    var transmission: TransmissionType
    var fuel: FuelType
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id" // <--- AÑADE ESTO
        case imageUrl = "image_url"
        case plate, brand, model, year, mileage, engine, transmission, fuel
    }
}

extension VehicleInformation {
    
    static var empty: Self { .init(userId: UUID(), plate: "", brand: "", model: "", year: 0, mileage: 0, engine: "", transmission: .automatic, fuel: .gasoline) }
    
    static var sample: Self {
        .init(userId: UUID(), plate: "ABC123", brand: "Toyota", model: "Celica", year: 1988, mileage: 10000, engine: "1.8L", transmission: .automatic, fuel: .gasoline)
    }
}



