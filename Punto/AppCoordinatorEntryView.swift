//
//  AppCoordinatorView.swift
//  Punto
//
//  Created by Sebastian Garcia on 28/04/26.
//
import SwiftUI

struct AppCoordinatorEntryView: View {
    @State private var appState: AppState
    @State private var carouselVM: CarouselViewModel
    @State private var coordinator: AppCoordinator

    
    init() {
        let appState = AppState()
        _appState = State(initialValue: appState)
        _coordinator = State(initialValue: AppCoordinator(appState: appState))
        _carouselVM = State(initialValue: CarouselViewModel(user: appState.user))
    }

    
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
                MainTabsView(user: appState.user)
                    .environment(carouselVM)


            case .auth:
                NavigationStack(path: Bindable(coordinator.authCoordinator).path) {
                    coordinator.authCoordinator.build(.auth)
                        .navigationDestination(for: AutAuthFlow.self) { screen in
                            coordinator.authCoordinator.build(screen)
                        }
                }
            }
        }.environment(coordinator)
    }
}
