//
//  SupabseAuthService.swift
//  Punto
//
//  Created by Sebastian Garcia on 24/04/26.
//

import Foundation
import Supabase
import Auth

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> AuthStatus
    func signup(email: String, password: String) async throws -> AuthStatus
    func getUser() async throws  -> Auth.User?
    
}

// MARK: - Auth Status
enum AuthStatus {
    case notDetermined
    case authenticated
    case notAuthenticated
}

struct AuthSupaService: AuthServiceProtocol {
    let client = SupabaseManagerSingleton.shared.client
    
    func login(email: String, password: String) async throws -> AuthStatus {
        try await client.auth.signIn(email: email, password: password)
        return .authenticated
    }
    
    func signup(email: String, password: String) async throws -> AuthStatus {
        try await client.auth.signUp(email: email, password: password)
        return .authenticated

    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getUser() async throws -> Auth.User? {
        guard let user = try? await client.auth.user() else { return nil }
        return user
    }
}
