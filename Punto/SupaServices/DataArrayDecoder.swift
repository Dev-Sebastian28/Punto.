//
//  DataArrayDecoder.swift
//  Punto
//
//  Created by Sebastian Garcia on 4/05/26.
//
import Foundation

struct DataArrayDecoder {
    static func map<Typee: Decodable>(_ type: Typee.Type, from responseData: Data) throws -> [Typee] {
        let decoder = JSONDecoder()
       decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([Typee].self, from: responseData)
    }
}
