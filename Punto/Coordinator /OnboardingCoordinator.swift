//
//  OnboardingCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 28/04/26.
//
import Foundation
import SwiftUI

enum AddVehicleRoutes: Hashable {
    case selectType        // Select the type of vehicle
    case manualForm(VehicleType)        // Manual form way
    case photoScan(VehicleType)         // Camera to add Vehicle
    case inputMode
}

enum OnboardingRoute: Hashable {
    case appIntroduction
    case createAccount
    case form1
    case form2
    case addVehicle
    case addDriver
    case vehicleFlow(AddVehicleRoutes)
}

@Observable
class OnboardingCoordinator {
    // MARK: Properties:
    var path = [OnboardingRoute]()
    
    
    // MARK: Dependencies:
    let appState: AppState
    let addVehicleCoordinator: AddVehicleCoordinator
    
    
    // MARK: Init
    init(appState: AppState) {
        self.appState = appState
        self.addVehicleCoordinator = AddVehicleCoordinator(appState: appState)
        setupAddVehicleBindings()
    }
    
    // MARK: CallBacks and Delegates:
    var finishOnBoarding: (() -> Void)?
    func didFinishOnBoarding() {
        finishOnBoarding?()
    }
    
    private func setupAddVehicleBindings() {
        
        addVehicleCoordinator.onSelectCreate = { [weak self] in
            self?.path.append(.vehicleFlow(.inputMode))
        }

        
        addVehicleCoordinator.onSelectedManual = { [weak self] in
            self?.path.append(.vehicleFlow(.selectType))
        }
        addVehicleCoordinator.onSelectedPhoto = { [weak self] in
            self?.path.append(.vehicleFlow(.selectType))
        }

        
        addVehicleCoordinator.onSelectVehicleType = { [weak self] type in
            if let inputMode = type.1 {
                switch inputMode {
                case .manual:
                    self?.path.append(.vehicleFlow(.manualForm(type.0)))
                case .photo:
                    self?.path.append(.vehicleFlow(.photoScan(type.0)))
                }
            } else {
                self?.path.append(.vehicleFlow(.inputMode))
            }
        }
        
        addVehicleCoordinator.onCancel = { [weak self] in
            self?.path.append(.addVehicle)
        }
    }
    
    @ViewBuilder
    func build(_ screen: OnboardingRoute) -> some View {
        switch screen {
        case .appIntroduction:
            IntroductionAppView()
        case .createAccount:
            CreationAccountView(appState: appState)
        case .form1:
            FirstFormView()
                .navigationBarBackButtonHidden()
        case .form2:
            SecondFormView()
                .navigationBarBackButtonHidden()
        case .addVehicle:
            AddVehicleView(appState: appState, mode: .firstTime)
                .navigationBarBackButtonHidden()
        case .addDriver:
            AddDriverView(user: appState.user)
        case .vehicleFlow(let route):
            addVehicleCoordinator.build(route)
        }
    }
    
    func navigate(to screen: OnboardingRoute) {
        path.append(screen)
        print(path)
    }
    
    func uniqueNavigation(to screen: OnboardingRoute) {
        path = .init()
        path.append(screen)
        print(path)
    }
}


