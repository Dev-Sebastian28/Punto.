//
//  VehicleInfo.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//
import Foundation

enum TransmissionType: String {
    case manual = "Manual"
    case automatic = "Automático"
}

enum FuelType: String {
    case diesel = "Diesel"
    case gasoline = "Gasoline"
    case other = "Other"
}

struct VehicleInformation: Identifiable {
    let id: UUID = UUID()
    var image: String
    var plate: String
    
    var brand: String
    var model: String
    var year: Int
    var mileage: Int
    var engine: String
    var transmission: TransmissionType
    var fuel: FuelType
    
    static var mock: Self {
        .init(image: "ford", plate: "DLK-1234", brand: "Ford", model: "F150", year: 2020, mileage: 100_000, engine: "V8", transmission: .automatic, fuel: .diesel)
    }
}




