//
//  CargoCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/05/26.
//
import Foundation
import SwiftUI

enum CargoRoute {
    case main
    case details
    case accept
}


@Observable
final class CargoCoordinator {
    var path: [CargoRoute] = []
    
    var onAccept: (() -> Void)?
    var onDenied: (() -> Void)?
    
    @ViewBuilder
    func build(path: CargoRoute) -> some View {
        switch path {
        case .details:
            CargoDetailView()
        case .accept:
            EmptyView()
        case .main:
            CargoView()
        }
    }
    
    func navigate(to: CargoRoute) {
        path.append(to)
    }
}
