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
    var currentRoot: AppRoot = .auth
    
    init(appState: AppState) {
        self.onBoardingCoordinator = OnboardingCoordinator(appState: appState)
        self.fleetCoordinator = FleetCoordinator(appState: appState)
        setupAuthBindings()
        setupOnboardingBindings()
    }
    
    // MARK: - Sub-Coordinators
    let authCoordinator = AuthCoordinator()
    let onBoardingCoordinator: OnboardingCoordinator
    let fleetCoordinator: FleetCoordinator
    

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


