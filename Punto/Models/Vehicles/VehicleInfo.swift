//
//  VehicleInfo.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/03/26.
//
import Foundation

struct VehicleInfo: Identifiable {
    var id: UUID = UUID()
    let image: String
    let plate: String
    
    let brand: String
    let model: String
    let year: Int
    let mileage: Int
    let engine: String
    let transmission: TransmissionType
    let fuel: FuelType

}

enum TransmissionType: String {
    case manual = "Manual"
    case automatic = "Automático"
}

enum FuelType: String {
    case diesel = "Diesel"
    case gasoline = "Gasoline"
    case other = "Other"
}
