//
//  ColombiaRoadKitRequirements.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/04/26.
//
import Foundation

struct ColombiaRoadKitRequirements: Codable {
    let id: String
    let jack: Bool
    let lugWrench: Bool
    let warningSigns: Bool
    let firstAidKit: FirstAidKit
    let fireExtinguisher: ColombiaFireExtinguisher
    let wheelChocks: Bool
    let toolKit: Bool
    let spareTire: Bool
    let flashlight: Bool
}

struct FirstAidKit: Codable {
    let present: Bool
    let antiseptics: Bool
    let alcohol: Bool
    let bandages: Bool
    let dressings: Bool
}

struct ColombiaFireExtinguisher: Codable {
    let present: Bool
    let expirationDate: String?
}
