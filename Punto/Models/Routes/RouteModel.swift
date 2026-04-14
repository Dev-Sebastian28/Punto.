//
//  RouteModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 14/04/26.
//
import Foundation

struct RouteModel: Codable {
    var startPointDirection: String
    var endPointDirection: String
    var distance: Double
    var duration: Double
}
