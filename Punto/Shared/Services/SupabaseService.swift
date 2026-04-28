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
}

struct AuthService: AuthServiceProtocol {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: AppConstants.baseURL)!,
            supabaseKey: AppConstants.projectAPIKey,
            options: SupabaseClientOptions(
                auth: .init(
                    emitLocalSessionAsInitialSession: true
                )
            )
        )
    }
    
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
    
    func getAuthState() async throws -> AuthStatus {
        let user = try? await client.auth.session.user
        return user == nil ? .notDetermined : .authenticated
    }
}
