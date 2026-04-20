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

let myRoute = RouteModel(startPointDirection: "", endPointDirection: "", distance: 0, duration: 0)

private struct SecretFormula {
    let key: String
}


