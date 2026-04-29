//
//  OnboardingCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 28/04/26.
//
import Foundation
import SwiftUI

enum OnboardingRoute: Hashable {
    case appIntroduction
    case createAccount
    case form1
    case form2
    case addVehicle
    case addDriver
}

@Observable
final class OnboardingCoordinator {
    var appState: AppState
    var path = [OnboardingRoute]()
    
    // Init
    init(appState: AppState) {
        self.appState = appState
    }
    
    // CallBack:
    var finishOnBoarding: (() -> Void)?
    
    @ViewBuilder
    func build(_ screen: OnboardingRoute) -> some View {
        switch screen {
        case .appIntroduction:
            IntroductionAppView()
        case .createAccount:
            EmptyView()
        case .form1:
            FirstFormView()
        case .form2:
            SecondFormView()
        case .addVehicle:
            AddVehicleView(user: appState.user)
        case .addDriver:
            AddDriverView(user: appState.user)
        }
    }
    
    func navigate(to screen: OnboardingRoute) {
        path.append(screen)
    }
    
    func didFinishOnBoarding() {
        finishOnBoarding?()
    }
}
