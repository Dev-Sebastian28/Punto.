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
    @State private var appState: AppState
    @State private var coordinator: AppCoordinator
    
    init() {
        let state = AppState()
        _appState = State(initialValue: state)
        _carouselVM = State(initialValue: CarouselViewModel(user: state.user))
        _coordinator = State(initialValue: AppCoordinator(appState: state))
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorEntryView(coordinator: coordinator, appState: appState)
        }
        .environment(coordinator)
        .environment(carouselVM)
    }
}


