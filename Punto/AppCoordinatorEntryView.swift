//
//  AppCoordinatorView.swift
//  Punto
//
//  Created by Sebastian Garcia on 28/04/26.
//
import SwiftUI

struct AppCoordinatorEntryView: View {
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
                MainTabsView(user: .mock)

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
