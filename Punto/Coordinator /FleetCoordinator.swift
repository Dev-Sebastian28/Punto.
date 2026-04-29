//
//  MainTabsCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 29/04/26.
//

import Foundation
import SwiftUI

// Route MainTabs Flow
enum FleetRoute: Hashable {
    case tasks
    case protocols
    case manteinances
    case expenses
    case main
}

@Observable
final class FleetCoordinator {
    var appState: AppState
    var path = [FleetRoute]()
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    @ViewBuilder
    func build(route: FleetRoute) -> some View {
        switch route {
        case .tasks:
            TaskView(user: appState.user)
        case .protocols:
            ProtocolsView(user: appState.user)
        case .manteinances:
            MaintenanceView(user: appState.user)
        case .expenses:
            ExpensesView(user: appState.user)
        case .main:
            MainTabView(user: appState.user)
        }
    }
    
    func navigate(to route: FleetRoute) {
        path.append(route)
    }
}
