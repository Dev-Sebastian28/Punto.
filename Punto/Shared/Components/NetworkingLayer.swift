//
//  NetworkingLayer.swift
//  Punto
//
//  Created by Sebastian Garcia on 20/04/26.
//

import Foundation

typealias ResponseData = (data: Data, response: HTTPURLResponse)

protocol HttpClient {
    func request(_ urlRequest: URLRequest) async throws -> ResponseData
}

enum HttpClientError: Error {
    case invalidResponse
    case invalidStatusCode(Int, Data?)
}

final class URLSessionHttpClient: HttpClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }

    func request(_ urlRequest: URLRequest) async throws -> ResponseData {
        let (data, response) = try await session.data(for: urlRequest)
        
        // URLSession returns URLResponse, so we need to cast it to HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpClientError.invalidResponse
        }

        return ResponseData(data: data, response: httpResponse)
    }
}

struct ResponseDataDecoder {
    static func map<T: Decodable>(_ responseData: ResponseData) throws -> T {
        guard (200...299).contains(responseData.response.statusCode) else {
            throw HttpClientError.invalidStatusCode(
                responseData.response.statusCode,
                responseData.data
            )
        }
        return try JSONDecoder().decode(T.self, from: responseData.data)
    }
}
