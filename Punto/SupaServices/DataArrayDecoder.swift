//
//  DataArrayDecoder.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/05/26.
//
import Foundation

struct DataArrayDecoder {
    static func map<Model: Decodable>(_ type: Model.Type, from responseData: Data) throws -> [Model] {
        let decoder = JSONDecoder()
       decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([Model].self, from: responseData)
    }
}

struct SingleDataDecoder {
    static func map<Model: Decodable>(_ type: Model.Type, from responseData: Data) throws -> Model {
        let decoder = JSONDecoder()
       decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Model.self, from: responseData)
    }
}
