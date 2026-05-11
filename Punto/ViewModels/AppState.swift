//
//  AppState.swift
//  Punto
//
//  Created by Sebastian Garcia on 14/04/26.
//
import Foundation
import Auth
import Supabase

@Observable
final class AppState {
    var user: User = .empty {
        willSet {
            print("DEBUG AppState: " + "User Change from: \(user)")
            print("------------------------------------------------------------------------------------------------")
            print("DEBUG AppState: " + "User Change to: \(newValue)")
        }
    }
    
    // MARK: - Init and Deinit:
    init() {
        print("👋 init: AppState")
        print("DEBUG AppState: " + user.id.uuidString)
    }
    
    deinit {
        print(" 👋 deinit: AppState")
    }
}


