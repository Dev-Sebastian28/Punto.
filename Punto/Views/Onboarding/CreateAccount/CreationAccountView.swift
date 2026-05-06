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
    @State private var phoneNumber: Int = 0
    @State private var vehiclesNumber: Int = 1
    @State private var vm: CreationAccountViewModel
    
    @Environment(AppCoordinator.self) var coordinator
    
    private var isValid: Bool {
        !name.isEmpty && phoneNumber != 0
    }
    
    init(appState: AppState) {
        _vm = State(initialValue: CreationAccountViewModel(user: appState.user))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 24) {
                    header
                    userInfo
                    vehiclesPicker
                    
                }.padding(.horizontal)
            }
            
            
            DButtonComp(
                text: "Create Account",
                color: .green,
                image: "checkmark",
            ) {
                guard isValid else  {
                    return coordinator.onBoardingCoordinator.uniqueNavigation(to: .form1)
                }
                
                vm.createAccount(
                    name: name,
                    phone: phoneNumber,
                    vehicles: vehiclesNumber
                )
                coordinator.onBoardingCoordinator.uniqueNavigation(to: .form1)
            }
            .padding()
        }.background(Color(.systemGroupedBackground))
    }
    
    private var header: some View {
        VStack(alignment: .center, spacing: 8) {
                
                VStack(alignment: .center) {
                    Text("Create Account")
                        .font(.title.bold())
                    HStack {
                        Text("Enter your personal info")
                        Text("optional (Recommended)")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
            
            VStack(spacing: 0) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.blue)
                Text("Select a profile picture")
            }
            
        }.frame(maxWidth: .infinity)
    }
    private var vehiclesPicker: some View {
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
                }.pickerStyle(.menu)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10)
        )
    }
    private var userInfo: some View {
        VStack(spacing: 16) {
            TextFieldComp(
                text: $name,
                prompt: "Full name",
                leadingIcon: "person"
            )
            
            TextFieldComp(
                intValue: $phoneNumber,
                prompt: "Phone number ",
                leadingIcon: "phone"
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10)
        )
    }
}


#Preview {
    CreationAccountView(appState: AppState())
        .environment(AppCoordinator(appState: AppState()))
}
