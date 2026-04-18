//
//  formsService.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/04/26.
//

import Foundation

enum OnBoardingFormRoute {
    case form1
    case form2
    var endPoint: String {
        switch self {
        case .form1:
            return "/form1"
        case .form2:
            return "/form2"
        }
    }
}

extension OnBoardingFormRoute {
    func sendAnswe(_ answer: String) async throws {
        let url = "http://127.0.0.1:8000\(self.endPoint)?response=\(answer)"
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            print("Error del servidor: \(httpResponse.statusCode)")
        }
        
        if let utf8String = String(data: data, encoding: .utf8) {
            print("Raw response: \(utf8String)")
        }
    }
}

