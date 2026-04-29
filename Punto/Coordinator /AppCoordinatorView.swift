//
//  AppCoordinatorView.swift
//  Punto
//
//  Created by Sebastian Garcia on 28/04/26.
//
import SwiftUI

struct AppCoordinatorView: View {
    var coordinator: AppCoordinator
    
    var body: some View {
        Group {
            switch coordinator.currentRoot {
            case .onboarding:
                NavigationStack(path: Bindable(coordinator.onBoardingCoordinator).path) {
                    coordinator.onBoardingCoordinator.build(.appIntroduction)
                        .navigationDestination(for: OnboardingRoute.self) { screen in
                            coordinator.onBoardingCoordinator.build(screen)
                        }
                }
                
            case .mainTabs:
                NavigationStack(path: Bindable(coordinator.fleetCoordinator).path) {
                    coordinator.fleetCoordinator.build(route: .main)
                        .navigationDestination(for: FleetRoute.self) { scren in
                            coordinator.fleetCoordinator.build(route: scren)
                        }
                }

            case .auth:
                NavigationStack(path: Bindable(coordinator.authCoordinator).path) {
                    coordinator.authCoordinator.build(.auth)
                        .navigationDestination(for: AutAuthFlow.self) { screen in
                            coordinator.authCoordinator.build(screen)
                        }
                }
            }
        }
    }
}
