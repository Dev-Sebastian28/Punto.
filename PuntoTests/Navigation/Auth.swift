//
//  Navigation.swift
//  PuntoTests
//
//  Created by Sebastian Garcia on 2/05/26.
//

import Testing
@testable import Punto
import Foundation

@Suite("Authentication Navigation Tests", .tags(.critical, .navigation))
struct AuthNavigationTests {
    
    
    @Test("Log in navigation - Succesful log in")
    func logInSuccesfulNavigation() async throws {
        let coordinator = await AuthCoordinator()
        let appState = await AppState()
        let serviceMock = AuthMock(authCoordinator: coordinator)

        
        let appCoordinator = await AppCoordinator(authCoordinator: coordinator, onboardingCoordinator: OnboardingCoordinator(appState: appState), fleetCoordinator: FleetCoordinator(appState: appState), cargoCoordinator: CargoCoordinator())
        
        let authViewModel = await AuthViewModel(service: serviceMock, coordinator: AuthCoordinator())
        
        try? #require(appCoordinator.currentRoot == .auth)
        
        serviceMock.loginResult = .success(.authenticated)
        await authViewModel.login(email: "test@test.com", password: "Test123$")
        
        #expect(appCoordinator.currentRoot == .mainTabs)
    }
    
    @Test("Log in navigation - Failure log in")
    func logInFailureNavigation() async throws {
        let coordinator = await AuthCoordinator()
        let appState = await AppState()
        let serviceMock = AuthMock(authCoordinator: coordinator)

        
        let appCoordinator = await AppCoordinator(authCoordinator: coordinator, onboardingCoordinator: OnboardingCoordinator(appState: appState), fleetCoordinator: FleetCoordinator(appState: appState), cargoCoordinator: CargoCoordinator())
        
        let authViewModel = await AuthViewModel(service: serviceMock, coordinator: AuthCoordinator())
        
        try? #require(appCoordinator.currentRoot == .auth)
        
        serviceMock.loginResult = .failure(AuthError.unknown)
        await authViewModel.login(email: "test@test.com", password: "d$")
        
        #expect(appCoordinator.currentRoot == .auth)
    }
    
    @Test("Sign Up navigation - Succesful Sign Up")
    func signUpSuccesfulNavigation() async throws {
        let coordinator = await AuthCoordinator()
        let appState = await AppState()
        let serviceMock = AuthMock(authCoordinator: coordinator)

        
        let appCoordinator = await AppCoordinator(authCoordinator: coordinator, onboardingCoordinator: OnboardingCoordinator(appState: appState), fleetCoordinator: FleetCoordinator(appState: appState), cargoCoordinator: CargoCoordinator())
        
        let authViewModel = await AuthViewModel(service: serviceMock, coordinator: AuthCoordinator())
        
        try? #require(appCoordinator.currentRoot == .auth)
        
        serviceMock.signupResult = .success(.authenticated)
        await authViewModel.signUp(email: "test@test.com", password: "Test123$")
        
        #expect(appCoordinator.currentRoot == .onboarding)
    }
    
    @Test("Sign Up navigation - Failure Sign Up")
    func signUpFailureNavigation() async throws {
        let coordinator = await AuthCoordinator()
        let appState = await AppState()
        let serviceMock = AuthMock(authCoordinator: coordinator)

        
        let appCoordinator = await AppCoordinator(authCoordinator: coordinator, onboardingCoordinator: OnboardingCoordinator(appState: appState), fleetCoordinator: FleetCoordinator(appState: appState), cargoCoordinator: CargoCoordinator())
        
        let authViewModel = await AuthViewModel(service: serviceMock, coordinator: AuthCoordinator())
        
        try? #require(appCoordinator.currentRoot == .auth)
        
        serviceMock.signupResult = .failure(AuthError.invalidCredentials)
        await authViewModel.signUp(email: "test@test.com", password: "d")
        
        #expect(appCoordinator.currentRoot == .auth)
    }
}
