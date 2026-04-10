//
//  PuntoApp.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/02/26.
//

import SwiftUI

@main
struct PuntoApp: App {
    @State private var router = NavigationRouter()
    @State private var userExample = User(
        name: "Sebastian",
        email: "ejemplo@correo.com",
        access: .admin, // Ajusta según tus enums
        country: .colombia
    )
    
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
                                    TaskView()
                                case .protocols:
                                    VehicleProtocolsView(quickSummary: [])
                                case .addprotocols:
                                    AddProtocolView()
                                case .manteinances:
                                    MaintenanceView(quickSummary: [])
                                case .expenses:
                                    ExpensesView()
                                
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }
            .environment(router)
        }
    }
}
