//
//  AuthStatus.swift
//  PuntoTests
//
//  Created by Sebastian Garcia on 27/04/26.
//

import Testing
@testable import Punto
import Foundation





@Suite("Auth State Tests", .tags(.critical, .auth))
struct AuthStateTests {
        
    @Test("Auth Login Status - Successful")
    @MainActor
    func authLoginStatusSuccess() async {
        let dependency = AuthMock()
        dependency.loginResult = .success(.authenticated)
        
        let viewModel = AuthViewModel(mode: .signIn, service: dependency)
        
        await viewModel.login(email: "test@test.com", password: "Test123$")
        
        #expect(viewModel.authStatus == .authenticated)
    }
    
    @Test("Auth Login Status - Failure")
    @MainActor
    func authLoginStatusFailure() async {
        let dependency = AuthMock()

        dependency.loginResult = .success(.notAuthenticated)
        
        let viewModel = AuthViewModel(mode: .signIn, service: dependency)
        
        await viewModel.login(email: "error@test.com", password: "wrong")
        
        #expect(viewModel.authStatus == .notAuthenticated)
    }
    
    @Test("Auth Sign Up Status - Success")
    @MainActor
    func authSignUpStatusSuccess() async {
        let dependency = AuthMock()

        dependency.signupResult = .success(.authenticated)
        
        let viewModel = AuthViewModel(mode: .signUp, service: dependency)
        
        await viewModel.signUp(email: "new@test.com", password: "Password123$")
        
        #expect(viewModel.authStatus == .authenticated)
    }

    @Test("Auth Sign Up Status - Error de Servidor")
    @MainActor
    func authSignUpStatusServerError() async {
        let dependency = AuthMock()
        dependency.signupResult = .failure(NSError(domain: "Server", code: 500))
        
        let viewModel = AuthViewModel(mode: .signUp, service: dependency)
        
        await viewModel.signUp(email: "test@test.com", password: "Password123!")
        
        #expect(viewModel.authStatus == .notDetermined)
    }
}
