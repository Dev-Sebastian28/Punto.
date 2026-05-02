//
//  User.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/02/26.
//

import Foundation



enum AvailableCountries: String, Codable {
    case colombia
    case argentina
}

struct User {
    var id: UUID
    var userInformation: UserInformation
    var vehicles: [Vehicle]
    var drivers: [User]

    init(id: UUID, userInformation: UserInformation, vehicles: [Vehicle], drivers: [User]) {
        self.id = id
        self.userInformation = userInformation
        self.vehicles = vehicles
        self.drivers = drivers
    }
    
    static var mock: User {
        User(id: UUID(),
             userInformation: UserInformation(
                name: "sebastian", email: "sebastian@gmail.com", phone: "3213123", country: .colombia
             ),
             vehicles: [
                TransportationVehicle(
                    vehicleInformation: .init(
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
}

struct UserInformation: Codable {
    var name: String
    var email: String
    var phone: String?
    var country: AvailableCountries
}



