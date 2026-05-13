//
//  ProfileCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/05/26.
//
import SwiftUI

// MARK: - ROUTES
enum ProfileRoute: Hashable {
    case main
    case profileDetails
    case security
    case vehicleHelpCenter
    case driverHelpCenter
    case cargoHelpCenter
    case helpCenter
    case contactSupport
    case faq
    case subscription
}

// MARK: - Coordinator
@Observable final class ProfileCoordinator {
    // MARK: - Properties:
    var path: [ProfileRoute] = []
    
    // MARK: - Dependency
    var appState: AppState
    
    // MARK: - Init
    init(appState: AppState) {
        self.appState = appState
    }
    
    @ViewBuilder
    func build(_ screen: ProfileRoute) -> some View {
        switch screen {
        case .main:
            ProfileView(user: appState.user)
        case .profileDetails:
            CreationAccountView(appState: appState)
        case .security:
            EmptyView()
        case .vehicleHelpCenter:
            AddVehicleView(appState: appState, mode: .addNew)
        case .driverHelpCenter:
            AddDriverView(user: appState.user)
        case .cargoHelpCenter:
            EmptyView()
        case .faq:
            EmptyView()
        case .subscription:
            EmptyView()
        case .helpCenter:
            EmptyView()
        case .contactSupport:
            EmptyView()
        }
    }
    
    func navigate(to route: ProfileRoute) {
        path.append(route)
    }

}
