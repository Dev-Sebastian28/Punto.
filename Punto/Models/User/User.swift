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
    var vehicles: [Vehicle] = []
    var drivers: [User] = []
    
    init(id: UUID = UUID(), name: String, email: String, access: ProfileAccess, country: AvailableCountries) {
        self.id = id
        self.name = name
        self.email = email
        self.access = .admin
        self.country = .colombia
        
    }
}


