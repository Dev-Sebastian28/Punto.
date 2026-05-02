//
//  VehicleInfo.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//
import Foundation
import SwiftUI

enum TransmissionType: String, Codable {
    case manual = "Manual"
    case automatic = "Automático"
}

enum FuelType: String, Codable {
    case diesel = "Diesel"
    case gasoline = "Gasoline"
    case other = "Other"
}


struct VehicleInformation: Identifiable, Codable {
    var id: UUID = UUID()
    var userId: UUID?
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
    static var sample: Self {
        .init(plate: "ABC123", brand: "Toyota", model: "Celica", year: 1988, mileage: 10000, engine: "1.8L", transmission: .automatic, fuel: .gasoline)
    }
}



