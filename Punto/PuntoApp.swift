//
//  PuntoApp.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/02/26.
//

import SwiftUI

@main
struct PuntoApp: App {
    @State private var carouselVM = CarouselViewModel(user: .mock)
    @State private var router = NavigationRouter()
    @State private var user: User = .mock
    var body: some Scene {
        WindowGroup {
            Group {
                switch router.root {
                case .onboarding:
                    NavigationStack(path: $router.onboardingPath) {
                        SignInView()
                            .navigationDestination(for: OnboardingRoute.self) { route in
                                switch route {
                                case .appIntroduction:
                                    IntroductionAppView()
                                case .createAccount:
                                    SignInView()
                                case .form1:
                                    FirstFormView()
                                case .form2:
                                    SecondFormView()
                                        .navigationBarBackButtonHidden(true)
                                case .addVehicle:
                                    AddVehicleView()
                                        .navigationBarBackButtonHidden(true)
                                case .addDriver:
                                    AddDriverView()
                                }
                            }
                    }
                case .mainTabs:
                    NavigationStack(path: $router.appPath) {
                        MainTabView()
                            .navigationDestination(for: AppRoute.self) { route in
                                switch route {
                                case .tasks:
                                    TaskView(user: user)
                                case .protocols:
                                    VehicleProtocolsView(user: user)
                                case .addprotocols:
                                    AddProtocolView()
                                case .manteinances:
                                    MaintenanceView(user: user)
                                case .expenses:
                                    ExpensesView(user: user)
                                
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }
            .environment(router)
            .environment(user)
        }
    }
}

