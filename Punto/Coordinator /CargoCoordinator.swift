//
//  CargoCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/05/26.
//
import Foundation
import SwiftUI

enum CargoRoute: Hashable {
    case main
    case details(cargo: Cargo)
    case accept
}


@Observable
final class CargoCoordinator {
    
    init(userId: UUID) {
        self.userId = userId
    }
    
    var userId: UUID
    var path: [CargoRoute] = []
    
    var onAccept: (() -> Void)?
    var onDenied: (() -> Void)?
    
    @ViewBuilder
    func build(path: CargoRoute) -> some View {
        switch path {
        case .details(let cargo):
            CargoDetailView(cargo: cargo)
        case .accept:
            EmptyView()
        case .main:
            CargoView(userId: userId)
        }
    }
    
    func navigate(to: CargoRoute) {
        path.append(to)
    }
}
