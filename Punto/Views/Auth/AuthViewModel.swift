//
//  AuthViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//

import Foundation

enum AuthMode {
    case signUp
    case signIn
}
@Observable
final class AuthViewModel {
    private(set) var mode: AuthMode
    
    init(mode: AuthMode) {
        self.mode = mode
    }
    
    func setMode(_ mode: AuthMode) {
        self.mode = mode
    }
    
    func makeRequest() {
        switch mode {
        case .signIn:
            print("Sign in")
        case .signUp:
            print("Sign up")
        }
    }
}
