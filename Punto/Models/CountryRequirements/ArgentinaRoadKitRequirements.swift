//
//  ArgentinaRoadKitRequirements.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/04/26.
//
import Foundation


struct ArgentinaRoadKitRequirements: Codable {
    let id: String
    let jack: Bool
    let lugWrench: Bool
    let warningSigns: Bool
    let reflectiveVest: Bool
    let recommendedFirstAidKit: FirstAidKit
    let fireExtinguisher: ArgentinaFireExtinguisher
    let wheelChocks: Bool
    let toolKit: Bool
    let spareTire: Bool
    let flashlight: Bool
}

struct ArgentinaFireExtinguisher: Codable {
    let present: Bool
    let expirationDate: String?
}
