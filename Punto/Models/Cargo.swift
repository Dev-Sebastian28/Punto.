//
//  Cargo.swift
//  Punto
//
//  Created by Sebastian Garcia on 22/04/26.
//
//  A Cargo represents a transportation contract that drivers can apply to.
//  Some fields (CargoRestrictedInfo) are only revealed once the contract
//  owner accepts the driver's request.

import Foundation

// MARK: - Enums

/// Lifecycle of the cargo while on the road.
enum CargoStatus: String, Codable, CaseIterable {
    case inCollection   // Driver is heading to pick up the cargo
    case inTransit      // Cargo has been picked up and is en route
    case delivered      // Cargo arrived at destination
}

/// Status of the driver's application to a cargo contract.
enum CargoRequestStatus: String, Codable, CaseIterable {
    case pending        // Awaiting owner's response
    case accepted       // Owner accepted the driver
    case declined       // Owner declined the driver
}

// MARK: - Restricted Info

/// Only available once the contract owner accepts the driver's request.
struct CargoRestrictedInfo: Codable, Hashable {
    let contactName: String
    let contactPhone: String
    let exactOriginAddress: String
    let exactDestinationAddress: String
    var notes: String?
}

// MARK: - Cargo

struct Cargo: Identifiable, Codable, Hashable {

    // MARK: Identity
    let id: UUID
    let ownerID: UUID           // References auth.users on Supabase
    var cargoName: String
    var cargoType: String       // Free text from backend

    // MARK: Status
    var cargoStatus: CargoStatus?   // nil until request is accepted

    // MARK: Public Location
    var origin: String          // City / region level
    var destination: String

    // MARK: Measurements
    var weightKg: Double
    var volumeCubicMeters: Double

    // MARK: Distances (computed by backend, immutable on client)
    let distanceToCargoKm: Double
    let distanceToDestinationKm: Double
    var totalRouteDistanceKm: Double {
        distanceToCargoKm + distanceToDestinationKm
    }

    // MARK: Pricing & Dates
    var price: Double
    var dueDate: Date
    let createdAt: Date

    // MARK: Restricted (nil until owner accepts)
    var restrictedInfo: CargoRestrictedInfo?
}

// MARK: - Mocks
extension Cargo {
    static var mockPending: Self {
        Cargo(
            id: UUID(),
            ownerID: UUID(),
            cargoName: "Furniture Load",
            cargoType: "Furniture",
            cargoStatus: nil,
            origin: "Boston, MA",
            destination: "Austin, TX",
            weightKg: 320,
            volumeCubicMeters: 4.5,
            distanceToCargoKm: 12,
            distanceToDestinationKm: 2850,
            price: 2000,
            dueDate: Calendar.current.date(byAdding: .day, value: 7, to: .now)!,
            createdAt: .now,
            restrictedInfo: nil
        )
    }

    static var mockAccepted: Self {
        var cargo = mockPending
        cargo.cargoStatus = .inCollection
        cargo.restrictedInfo = CargoRestrictedInfo(
            contactName: "John Doe",
            contactPhone: "+1 617 555 0100",
            exactOriginAddress: "123 Harbor St, Boston, MA 02110",
            exactDestinationAddress: "456 Congress Ave, Austin, TX 78701",
            notes: "Fragile items, handle with care"
        )
        return cargo
    }
}

struct CargoRequest: Identifiable, Codable {
    let id: UUID
    let cargoID: UUID
    let driverID: UUID
    var status: CargoRequestStatus   // pending, accepted, declined
    let createdAt: Date
}
