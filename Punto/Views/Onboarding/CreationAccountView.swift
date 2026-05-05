//
//  CreationAccountView.swift
//  Punto
//
//  Created by Sebastian Garcia on 1/05/26.
//

import SwiftUI

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
        VStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // HEADER
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.blue)
                            
                            VStack(alignment: .leading) {
                                Text("Create Account")
                                    .font(.title.bold())
                                Text("Enter your personal info")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    // CARD: USER INFO
                    VStack(spacing: 16) {
                        TextFieldComp(
                            text: $name,
                            prompt: "Full name",
                            leadingIcon: "person"
                        )
                        
                        TextFieldComp(
                            text: $phoneNumber,
                            prompt: "Phone number",
                            leadingIcon: "phone"
                        )
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 10)
                    )
                    
                    
                    // CARD: VEHICLES
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Vehicles")
                            .font(.headline)
                        
                        HStack {
                            Text("How many do you have?")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Picker("", selection: $vehiclesNumber) {
                                ForEach(1...20, id: \.self) { number in
                                    Text("\(number)").tag(number)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 10)
                    )
                }
                .padding()
            }
            
            
            // BOTÓN FIJO ABAJO
            DButtonComp(
                text: "Create Account",
                color: .green,
                image: "checkmark",
                isEnabled: isValid
            ) {
                vm.createAccount(name: name, phone: phoneNumber, vehicles: vehiclesNumber)
                coordinator.onBoardingCoordinator.uniqueNavigation(to: .form1)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}

@Observable
final class CreationAccountViewModel {
    private var user: User
    
    func createAccount(name: String, phone: String, vehicles: Int) {
        user.userInformation.name = name
        user.phone = phone
    }
    init(user: User) {
        self.user = user
    }
}

#Preview {
    CreationAccountView(appState: AppState())
        .environment(AppCoordinator(appState: AppState()))
}
