//
//  MainTabView.swift
//  Punto
//
//  Created by OpenAI on 2026.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @Environment(NavigationRouter.self) var router
    init(user: User) {
        self.user = user
    }
    var body: some View {
            TabView {
                Tab("Fleet", systemImage: "truck.box.fill") {
                    FleetView(user: user)
                }

                Tab("Expenses", systemImage: "banknote.fill") {
                    EmptyView()
                }

                Tab("Driver", systemImage: "person.crop.circle.fill") {
                    DriverControlPanel()
                }
            }
        
    }
}


#Preview {
    MainTabView(user: .mock)
        .environment(NavigationRouter())
}
