//
//  AddVehicleCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 13/05/26.
//
import SwiftUI
import Foundation

enum addVehicleMode {
    case manual
    case photo
}

@Observable
final class AddVehicleCoordinator {
    // MARK: Properties:
    var selectedType: VehicleType = .transportVehicle 
    var selectedMode: addVehicleMode? = .manual
    var addVehicleVM: AddVehicleViewModel
    
    // MARK: Dependencies:
    var appState: AppState
    
    // MARK: Init
    init(appState: AppState) {
        self.appState = appState
        self.addVehicleVM = AddVehicleViewModel(appState: appState)
    }
    
    // MARK: Delegates and callbacks
    var onCancel: (() -> Void)?

    var onSelectedManual: (() -> Void)?
    var onSelectedPhoto: (() -> Void)?
    var onSelectVehicleType: (((VehicleType, addVehicleMode?)) -> Void)?
    var onSelectCreate: (() -> Void)?
    
    func didSelectManual() {
        selectedMode = .manual
        onSelectedManual?()
    }
    
    func didSelectPhoto() {
        selectedMode = .photo
        onSelectedPhoto?()
    }
    
    func didSelectVehicleType(_ mode: VehicleType) {
        selectedType = mode
        onSelectVehicleType?((mode, selectedMode))
    }
    
    func didSelectCreate() {
        onSelectCreate?()
    }
    
    func didCancel() {
        onCancel?()
    }

    @ViewBuilder
    func build(_ screen: AddVehicleRoutes) -> some View {
        switch screen {
        case .selectType:
            SelectVehicleType(coordinator: self)
        case .manualForm(let mode):
            AddVehicleForm(vm: addVehicleVM, userId: appState.user.id, mode: mode)
        case .photoScan:
            PropertyCardScanView()
        case .inputMode:
            SelectVehicleMode()
        }
    }
}
