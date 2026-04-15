//
//  PuntoApp.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/02/26.
//

import SwiftUI

@main
struct PuntoApp: App {
    @State private var carouselVM: CarouselViewModel
    @State private var router: NavigationRouter
    @State private var appState: AppState
    
    init() {
            let state = AppState()
            _appState = State(initialValue: state)
            _carouselVM = State(initialValue: CarouselViewModel(user: state.user))
            _router = State(initialValue: NavigationRouter())
        }
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch router.root {
                case .onboarding:
                    NavigationStack(path: $router.onboardingPath) {
                        SignInView()
                            .navigationDestination(for: OnboardingRoute.self) { route in
                                switch route {
                                case .appIntroduction:  IntroductionAppView()
                                case .createAccount:    SignInView()
                                case .form1:            FirstFormView()
                                case .form2:            SecondFormView().navigationBarBackButtonHidden(true)
                                case .addVehicle:       AddVehicleView().navigationBarBackButtonHidden(true)
                                case .addDriver:        AddDriverView()
                                }
                            }
                    }
                case .mainTabs:
                    NavigationStack(path: $router.appPath) {
                        MainTabView()
                            .navigationDestination(for: AppRoute.self) { route in
                                switch route {
                                case .tasks:        TaskView(user: appState.user)
                                case .protocols:    VehicleProtocolsView(user: appState.user)
                                case .manteinances: MaintenanceView(user: appState.user)
                                case .expenses:     ExpensesView(user: appState.user)
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }

            .environment(carouselVM)
            .environment(router)
            .environment(appState)
        }
    }
}

