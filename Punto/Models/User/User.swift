//
//  User.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation

struct User {
    // Id Used in database
    var id: UUID
    var userInformation: UserProfile
    var vehicles: [Vehicle]

    init(id: UUID, userInformation: UserProfile, vehicles: [Vehicle]) {
        self.id = id
        self.userInformation = userInformation
        self.vehicles = vehicles
    }
    
    static var mock: User {
        User(id: UUID(),
             userInformation: UserProfile(
                id: UUID(),
                fullName: "sebastian",
                email: "sebas@gmail.com"
             ),
             vehicles: [
                TransportationVehicle(
                    vehicleInformation: .init(
                        userId: UUID(),
                        imageUrl: nil,
                        plate: "DMW-2342",
                        brand: "Volvo",
                        model: "X900x",
                        year: 2020,
                        mileage: 10000,
                        engine: "V8",
                        transmission: .automatic,
                        fuel: .diesel
                    )
                ),
                PrivateVehicle(
                    vehicleInformation: .init(
                        userId: UUID(),
                        imageUrl: nil,
                        plate: "AFV-2342",
                        brand: "Ford",
                        model: "F-150",
                        year: 2020,
                        mileage: 1000000,
                        engine: "V8o",
                        transmission: .automatic,
                        fuel: .diesel
                    )
                ),
                TransportationVehicle(
                    vehicleInformation: .init(
                        userId: UUID(),
                        imageUrl: nil,
                        plate: "TGB-2342",
                        brand: "Kenworth",
                        model: "T800",
                        year: 2014,
                        mileage: 240000,
                        engine: "V8",
                        transmission: .manual,
                        fuel: .gasoline
                    )
                )
            ])
    }
    static var empty: User {
        User(id: UUID(), userInformation: UserProfile(id: UUID(), fullName: "", email: ""), vehicles: [])

    }
}

// MARK: User editable information:
// I would like to implemet User real id and user driver license

struct UserProfile: Codable {
    var id: UUID                        // referencia a auth.users
    var fullName: String                // User Full Name
    var phone: String?                  // User optional phone (recommended)
    var email: String                   // User optional email (recommended)
    var avatar: String?                 // User Profile Picture (recommended)
     
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case phone
        case email
        case avatar
    }
}

