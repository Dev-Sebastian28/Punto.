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

struct User {
    let id: UUID
    let name: String
    let email: String
    let access: ProfileAccess
    // Nunca  !!!! var password: String = "123456$" que opciones hay para guardar datos sensibles
    var country: AvailableCountries
    var vehicles: [Vehicle] =
    [
        TransportationVehicle(vehicleInformation: .init(id: UUID(), image: "volvo", plate: "DMW-2342", brand: "Volvo", model: "X900x", year: 2020, mileage: 200000, engine: "V8", transmission: .automatic, fuel: .diesel))
        
        ,PrivateVehicle(vehicleInformation: .init(id: UUID(), image: "ford", plate: "AFV-2342", brand: "Ford", model: "F-150", year: 2020, mileage: 20000, engine: "V8o", transmission: .automatic, fuel: .diesel))
        
        ,TransportationVehicle(vehicleInformation: .init(id: UUID(), image: "ken", plate: "TGB-2342", brand: "kenworth", model: "T800", year: 214, mileage: 2000000, engine: "V8", transmission: .manual, fuel: .gasoline))
    ]
    
    var drivers: [User] = []
    
    init(id: UUID = UUID(), name: String, email: String, access: ProfileAccess, country: AvailableCountries) {
        self.id = id
        self.name = name
        self.email = email
        self.access = .admin
        self.country = .colombia
        
    }
}

