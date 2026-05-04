//
//  AuthMock.swift
//  PuntoTests
//
//  Created by Sebastian Garcia on 27/04/26.
//

@testable import Punto
import Foundation

enum AuthError: Error {
    case invalidCredentials
    case unknown
}

/// Un Mock profesional debe permitir:
/// 1. Controlar el resultado (Éxito/Error).
/// 2. Simular latencia de red.
/// 3. Registrar llamadas (Spying) para unit testing.
final class AuthMock: AuthServiceProtocol {
    // MARK: - Coordinator Dependence
    let authCoordinator: AuthCoordinator

    // MARK: - init
    init(authCoordinator: AuthCoordinator) {
        self.authCoordinator = authCoordinator
    }
    
    init() {
        self.authCoordinator = AuthCoordinator(appState: AppState())
    }

    
    // MARK: - Configuration Properties
    /// Define qué debe devolver cada método
    var loginResult: Result<Punto.AuthStatus, Error> = .success(.authenticated)
    var signupResult: Result<Punto.AuthStatus, Error> = .success(.authenticated)
    
    /// Simula el delay del servidor (útil para probar ProgressViews)
    var networkDelay: UInt64 = 10000


    // MARK: - Protocol Methods
    func login(email: String, password: String) async throws -> Punto.AuthStatus {
        
        // Simular delay de red si se configura
        if networkDelay > 0 {
            try await Task.sleep(nanoseconds: networkDelay)
        }
        
        // Retornar resultado configurado o lanzar error
        switch loginResult {
        case .success(let status):
            authCoordinator.didFinishLogin()
            return status
        case .failure:
            return .notAuthenticated
            
        }
    }

    func signup(email: String, password: String) async throws -> Punto.AuthStatus {
        if networkDelay > 0 {
            try await Task.sleep(nanoseconds: networkDelay)
        }
        
        switch signupResult {
        case .success(let status):
            authCoordinator.didFinishSignUp()

            return status
        case .failure:
            return .notAuthenticated
        }
    }
}
