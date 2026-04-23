//
//  Cargo.swift
//  Punto
//
//  Created by Sebastian Garcia on 22/04/26.
//


struct Cargo: Identifiable, Decodable {
    var id: Int
    var origine: String
    var destination: String
    var weight: Int
    var type: String
    var distance: Int
}