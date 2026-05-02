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
            print("curent root changed from \(currentRoot) to \(newValue)")
        }
    }
    
    // MARK: - Init
    init(appState: AppState) {
        self.authCoordinator = AuthCoordinator()
        self.onBoardingCoordinator = OnboardingCoordinator(appState: appState)
        self.fleetCoordinator = FleetCoordinator(appState: appState)
        self.cargoCoordinator = CargoCoordinator()
        setupAuthBindings()
        setupOnboardingBindings()
    }
    
    // MARK: - Test Init
    init(authCoordinator: AuthCoordinator, onboardingCoordinator: OnboardingCoordinator, fleetCoordinator: FleetCoordinator, cargoCoordinator: CargoCoordinator) {
        
        self.authCoordinator = authCoordinator
        self.onBoardingCoordinator = onboardingCoordinator
        self.fleetCoordinator = fleetCoordinator
        self.cargoCoordinator = cargoCoordinator
        setupAuthBindings()
        setupOnboardingBindings()
    }
    
    
    // MARK: - Sub-Coordinators
    let authCoordinator: AuthCoordinator
    let onBoardingCoordinator: OnboardingCoordinator
    let fleetCoordinator: FleetCoordinator
    let cargoCoordinator: CargoCoordinator
     
    
    
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



