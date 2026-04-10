//
//  User.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation

enum ProfileAccess {
    case admin
    case user
    case driver
}

enum AvailableCountries: String, Codable {
    case colombia
    case argentina
}

import Foundation
import Observation

@Observable
final class User {
    let id: UUID
    let name: String
    let email: String
    let access: ProfileAccess
    var country: AvailableCountries
    var vehicles: [Vehicle]
    var drivers: [User]

    init(id: UUID = UUID(), name: String, email: String, access: ProfileAccess, country: AvailableCountries) {
        self.id = id
        self.name = name
        self.email = email
        self.access = access
        self.country = country
        self.vehicles = [
            TransportationVehicle(vehicleInformation: .init(id: UUID(), image: "volvo", plate: "DMW-2342", brand: "Volvo", model: "X900x", year: 2020, mileage: 200000, engine: "V8", transmission: .automatic, fuel: .diesel)),
            PrivateVehicle(vehicleInformation: .init(id: UUID(), image: "ford", plate: "AFV-2342", brand: "Ford", model: "F-150", year: 2020, mileage: 20000, engine: "V8o", transmission: .automatic, fuel: .diesel)),
            TransportationVehicle(vehicleInformation: .init(id: UUID(), image: "ken", plate: "TGB-2342", brand: "Kenworth", model: "T800", year: 2014, mileage: 2000000, engine: "V8", transmission: .manual, fuel: .gasoline))
        ]
        self.drivers = []
    }

    static var mock: User {
        User(name: "Sebastian", email: "ejemplo@correo.com", access: .admin, country: .colombia)
    }
}




