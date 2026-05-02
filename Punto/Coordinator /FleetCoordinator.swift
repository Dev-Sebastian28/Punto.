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
    case fleet
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
            TaskView(appState: appState)
        case .protocols:
            ProtocolsView(appState: appState)
        case .manteinances:
            MaintenanceView(appState: appState)
        case .expenses:
            ExpensesView(appState: appState)
        case .fleet:
            FleetView(appState: appState)
        }
    }
    
    func navigate(to route: FleetRoute) {
        path.append(route)
    }
}
