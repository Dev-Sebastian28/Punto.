//
//  OnBoardingRoute.swift
//  Punto
//
//  Created by Sebastian Garcia on 3/04/26.
//

import Foundation
      
enum AppRoot {
    case onboarding
    case mainTabs
}

enum OnboardingRoute: Hashable {
    case appIntroduction
    case createAccount
    case form1
    case form2
    case addVehicle
    case addDriver
}

enum AppRoute: Hashable {
    case tasks
    case protocols
    case addprotocols
    case manteinances
    case expenses
    
}

@Observable @MainActor
final class NavigationRouter {
    var root: AppRoot = .onboarding
    var onboardingPath = [OnboardingRoute]()
    var appPath = [AppRoute]()
    
    func navigate(to route: OnboardingRoute) {
        guard onboardingPath.last != route else { return }
        onboardingPath.append(route)
    }

    func navigate(to route: AppRoute) {
        guard appPath.last != route else { return }
        appPath.append(route)
    }

    func replace(with route: OnboardingRoute) {
        onboardingPath = [route]
    }

    func popOnboarding() {
        guard !onboardingPath.isEmpty else { return }
        onboardingPath.removeLast()
    }

    func popApp() {
        guard !appPath.isEmpty else { return }
        appPath.removeLast()
    }
    func popToOnboardingRoot() {
        onboardingPath.removeAll()
    }

    func popToAppRoot() {
        appPath.removeAll()
    }

    func showMainTabs() {
        onboardingPath.removeAll()
        appPath.removeAll()
        root = .mainTabs
    }

    func showOnboarding() {
        appPath.removeAll()
        onboardingPath.removeAll()
        root = .onboarding
    }
}

