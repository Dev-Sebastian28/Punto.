//
//  User.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation

struct User {
    var id: UUID
    var userInformation: UserProfile
    var vehicles: [Vehicle]
    var drivers: [User]

    init(id: UUID, userInformation: UserProfile, vehicles: [Vehicle], drivers: [User]) {
        self.id = id
        self.userInformation = userInformation
        self.vehicles = vehicles
        self.drivers = drivers
    }
    
    static var mock: User {
        User(id: UUID(),
             userInformation: UserProfile(
                name: "sebastian"
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
            ],
             drivers: [])
    }
    static var empty: User {
      User(id: UUID(), userInformation: UserProfile(name: ""), vehicles: [], drivers: [])

    }
}

struct UserProfile: Codable {
    var name: String
    var phone: Int?
    var email: String?
    var avatar: String?
}

