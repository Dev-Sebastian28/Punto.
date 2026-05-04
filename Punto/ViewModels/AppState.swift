//
//  AppState.swift
//  Punto
//
//  Created by Sebastian Garcia on 14/04/26.
//
import Foundation

@Observable
final class AppState {
    var user: User = .mock {
        willSet {
            print("changed from \(user) to \(newValue)")
        }
    }
    
    init() {
        print(" 👋 init: AppState")
        print(user.id)
    }
    
    deinit {
        print(" 👋 deinit: AppState")
    }
}

var empty = User(id: UUID(), userInformation: UserInformation(name: "", country: .argentina), vehicles: [], drivers: [])
