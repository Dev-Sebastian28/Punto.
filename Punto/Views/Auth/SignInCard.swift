//
//  SignInCard.swift
//  Punto
//

import SwiftUI

struct SignInCard: View {
    @Environment(NavigationRouter.self) var router
    @State private var email: String = ""
    @State private var password: String = ""

    var vm: AuthViewModel

    private var canSubmit: Bool {
        !email.isEmpty && !password.isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Sign In")
                    .font(.system(.title2, design: .default, weight: .bold))
                    .foregroundStyle(.primary)

                Text("Use your credentials to access your account.")
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 4)

            TextFieldComp(
                text: $email,
                prompt: "Email",
                leadingIcon: "envelope",
                color: .myBlue
            )

            SecureInputField(
                title: "Password",
                binding: $password,
                prompt: "Your password"
            )

            HStack {
                Spacer()
                Button {
                    // Forgot password
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.bottom, 4)

            // Error del VM
            if let error = vm.operationState.error {
                FieldErrorLabel(error.displayMessage)
            }

            DButtonComp(
                text: "Sign In to Punto",
                color: .myBlue,
                image: "arrow.right.circle.fill",
                isEnabled: canSubmit && !vm.operationState.isLoading
            ) {
                Task { await vm.login(email: email, password: password) }
            }
            .overlay(loadingOverlay)
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .onDisappear {
            email = ""
            password = ""
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
}

#Preview {
    SignInCard(vm: AuthViewModel(mode: .signIn, service: .init()))
        .environment(NavigationRouter())
}
