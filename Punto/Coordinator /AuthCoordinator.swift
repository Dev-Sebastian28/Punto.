//
//  AutAuthCoordinator.swift
//  Punto
//
//  Created by Sebastian Garcia on 28/04/26.
//
import Foundation
import SwiftUI

// Auth Flow
enum AutAuthFlow: Hashable {
    case login
    case aboutPunto
   // case forgotPassword
   // case resetPassword
}


@Observable
final class AuthCoordinator {
    var path = [AutAuthFlow]()
    
    var onLogin: (() -> Void)?
    var onSignUp: (() -> Void)?

    @ViewBuilder
    func build(_ screen: AutAuthFlow) -> some View {
        switch screen {
        case .login:
            AuthView() 
        case .aboutPunto:
            IntroductionAppView()
        }
    }
}
