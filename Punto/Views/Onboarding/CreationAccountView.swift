//
//  CreationAccountView.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/05/26.
//

import SwiftUI

struct CreationAccountView: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var vehiclesNumber: Int = 1
    @State private var vm: CreationAccountViewModel
    
    @Environment(AppCoordinator.self) var coordinator
    
    
    private var isValid: Bool {
        !name.isEmpty && !phoneNumber.isEmpty 
    }
    
    init(appState: AppState) {
        _vm = State(initialValue: CreationAccountViewModel(user: appState.user))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "person.fill")
                    .font(.title)
                    .foregroundStyle(Color.blue)
                    .genericRoundedBackground(color: .blue.opacity(0.1))
                
                VStack(alignment: .leading) {
                    Text("Account Information")
                        .font(.title2.bold())
                    Text("Name and Lastname")
                }
            }
            
            TextFieldComp(
                text: $name,
                prompt: "Whats your name",
                leadingIcon: "pencil"
            )
            
            TextFieldComp(
                text: $phoneNumber,
                prompt: "Whats your phone number",
                leadingIcon: "phone"
            ).padding(.bottom)

            
            HStack {
                Text("Number of vehicles you have:")
                Picker("Select a number", selection: $vehiclesNumber) {
                    ForEach(1...100, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .genericCapsuleBackground(color: .blue.opacity(0.1))
                .pickerStyle(.menu)
            }
            
            DButtonComp(
                text: "Create",
                color: .green,
                image: "plus",
                isEnabled: isValid
            ) {
                vm.createAccount(name: name, phone: phoneNumber, vehicles: vehiclesNumber)
                coordinator.onBoardingCoordinator.uniqueNavigation(to: .form1)
            }
        }.padding(.horizontal)
    }
}

@Observable
final class CreationAccountViewModel {
    private var user: User
    
    func createAccount(name: String, phone: String, vehicles: Int) {
        user.userInformation.name = name
        user.userInformation.phone = phone
    }
    init(user: User) {
        self.user = user
    }
}

#Preview {
    CreationAccountView(appState: AppState())
        .environment(AppCoordinator(appState: AppState()))
}
