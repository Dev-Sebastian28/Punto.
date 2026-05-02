//
//  SignUpCard.swift
//  Punto
//

import SwiftUI

struct SignUpCard: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(AppCoordinator.self) var coordinator

    var vm: AuthViewModel
    
    private var areCredentialsValid: Bool {
        password == confirmPassword

    }

    private var isValid: Bool {
        !email.isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Sign Up")
                .font(.system(.title2, design: .default, weight: .bold))
                .foregroundStyle(.primary)

            TextFieldComp(
                text: $email,
                prompt: "Email",
                leadingIcon: "envelope",
                color: .myBlue
            )

            SecureInputField(
                title: "Password",
                binding: $password,
                prompt: "Make it strong"
            )

            SecureInputField(
                title: "Confirm Password",
                binding: $confirmPassword,
                prompt: "Repeat your password"
            )
            
            if !areCredentialsValid {
                FieldErrorLabel("Credentials don't match")

            }

            if let error = vm.operationState.error {
                FieldErrorLabel(error.displayMessage)
            }

            DButtonComp(
                text: "Sign Up to Punto",
                color: .myBlue,
                image: "arrow.right",
                isEnabled: isValid && !vm.operationState.isLoading && areCredentialsValid
            )
            {
                Task { await vm.signUp(email: email, password: password) }
            }
            .overlay(loadingOverlay)
            .padding(.top, 4)

            appIntroductionButton
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .onDisappear {
            email = ""
            password = ""
            confirmPassword = ""
        }
    }

    @ViewBuilder
    private var loadingOverlay: some View {
        if vm.operationState.isLoading {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white.opacity(0.6))
            ProgressView()
        }
    }

    private var appIntroductionButton: some View {
        Button {
            coordinator.onBoardingCoordinator.navigate(to: .appIntroduction)
        } label: {
            Text("Watch App Introduction")
                .font(.headline)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
        }
    }
}

#Preview {
    SignUpCard(
        vm: AuthViewModel(
            mode: .signUp,
            service: AuthService(),
            coordinator: AuthCoordinator(appState: AppState())
        )
    ).environment(AppCoordinator(appState: AppState()))
}
