//
//  InvitationService.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//
import Foundation

class DriverInvitationService {
    let basedURL = "http://127.0.0.1:8000/addDriver"
    
    func sendInvitation(_ invitation: Invitation) async throws -> String {
        guard let url = URL(string: basedURL) else { return "Check URL" }
        
        // Request Method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(invitation)
        
        // Session with request
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let data = try? JSONDecoder().decode(Response.self, from: data) {
            return data.status
        }
        return ""
    }
    private struct Response: Decodable {
        let status: String
        let message: String
        let code: Int
    }
}
