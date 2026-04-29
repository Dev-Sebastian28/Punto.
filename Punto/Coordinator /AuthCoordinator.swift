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
    case auth
    case aboutPunto
    // case forgotPassword
    // case resetPassword
}


@Observable
final class AuthCoordinator {
    var path = [AutAuthFlow]()
    
    var onLoginSuccess: (() -> Void)?
    var onSignUpSuccess: (() -> Void)?
    
    @ViewBuilder
    func build(_ screen: AutAuthFlow) -> some View {
        switch screen {
        case .auth:
            let viewModel = AuthViewModel(service: AuthService(), coordinator: self)
            AuthView(vm: viewModel)
        case .aboutPunto:
            IntroductionAppView()
        }
    }
    
    func showAboutPunto() {
        path.append(.aboutPunto)
    }
    
    func didFinishLogin() {
        onLoginSuccess?()
    }
    
    func didFinishSignUp() {
        onSignUpSuccess?()
    }

}
