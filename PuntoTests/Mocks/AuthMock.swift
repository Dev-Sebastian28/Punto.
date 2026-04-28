//
//  AuthMock.swift
//  PuntoTests
//
//  Created by Sebastian Garcia on 27/04/26.
//

@testable import Punto

import Foundation

/// Un Mock profesional debe permitir:
/// 1. Controlar el resultado (Éxito/Error).
/// 2. Simular latencia de red.
/// 3. Registrar llamadas (Spying) para unit testing.
final class AuthMock: AuthServiceProtocol {
    
    // MARK: - Configuration Properties
    /// Define qué debe devolver cada método
    var loginResult: Result<Punto.AuthStatus, Error> = .success(.authenticated)
    var signupResult: Result<Punto.AuthStatus, Error> = .success(.authenticated)
    
    /// Simula el delay del servidor (útil para probar ProgressViews)
    var networkDelay: UInt64 = 10000

    // MARK: - Spy Properties
    /// Registran si los métodos fueron llamados y con qué parámetros
    private(set) var loginCallCount = 0
    private(set) var lastLoginEmail: String?
    private(set) var signupCallCount = 0

    // MARK: - Protocol Methods
    func login(email: String, password: String) async throws -> Punto.AuthStatus {
        loginCallCount += 1
        lastLoginEmail = email
        
        // Simular delay de red si se configura
        if networkDelay > 0 {
            try await Task.sleep(nanoseconds: networkDelay)
        }
        
        // Retornar resultado configurado o lanzar error
        switch loginResult {
        case .success(let status):
            return status
        case .failure(let error):
            throw error
        }
    }

    func signup(email: String, password: String) async throws -> Punto.AuthStatus {
        signupCallCount += 1
        
        if networkDelay > 0 {
            try await Task.sleep(nanoseconds: networkDelay)
        }
        
        switch signupResult {
        case .success(let status):
            return status
        case .failure(let error):
            throw error
        }
    }
}
