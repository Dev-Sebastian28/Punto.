//
//  AppCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 28/04/26.
//

import Foundation
import Observation

enum AppRoot {
    case auth
    case onboarding
    case mainTabs
}

@Observable
final class AppCoordinator {
    var currentRoot: AppRoot = .auth  {
        willSet {
            print("Debug: AppCoordinator - curent root changed from \(currentRoot) to \(newValue)")
        }
    }
    
    // MARK: - Init
    init(appState: AppState) {
        self.authCoordinator = AuthCoordinator(appState: appState)
        self.onBoardingCoordinator = OnboardingCoordinator(appState: appState)
        self.fleetCoordinator = FleetCoordinator(appState: appState)
        self.cargoCoordinator = CargoCoordinator(userId: appState.user.id)
        self.profileCoordinator = ProfileCoordinator(appState: appState)
        setupAuthBindings()
        setupOnboardingBindings()
    }
    
    // MARK: - Test Init
    init(authCoordinator: AuthCoordinator, onboardingCoordinator: OnboardingCoordinator, fleetCoordinator: FleetCoordinator, cargoCoordinator: CargoCoordinator, profileCoordinator: ProfileCoordinator) {
        
        self.authCoordinator = authCoordinator
        self.onBoardingCoordinator = onboardingCoordinator
        self.fleetCoordinator = fleetCoordinator
        self.cargoCoordinator = cargoCoordinator
        self.profileCoordinator = profileCoordinator
        setupAuthBindings()
        setupOnboardingBindings()
    }
    
    
    // MARK: - Sub-Coordinators
    let authCoordinator: AuthCoordinator
    let onBoardingCoordinator: OnboardingCoordinator
    let fleetCoordinator: FleetCoordinator
    let cargoCoordinator: CargoCoordinator
    let profileCoordinator: ProfileCoordinator
    
    
    
    private func setupAuthBindings() {
        authCoordinator.onLoginSuccess = { [weak self] in
            self?.currentRoot = .mainTabs
        }
        
        authCoordinator.onSignUpSuccess = { [weak self] in
            self?.currentRoot = .onboarding
        }
    }
    
    private func setupOnboardingBindings() {
        onBoardingCoordinator.finishOnBoarding = { [weak self] in
            self?.currentRoot = .mainTabs
        }
    }
    
}




