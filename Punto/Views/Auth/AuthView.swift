//
//  AuthView.swift
//  Punto
//

import SwiftUI

struct AuthView: View {
    @State var vm: AuthViewModel
    private let viewStyle: LinearGradient = LinearGradient(
        colors: [.myBlue, .white, .myBlue],
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        ZStack {
            viewStyle.ignoresSafeArea()
            
            VStack(spacing: 25) {
                authModeSelector
                Group {
                    switch vm.mode {
                    case .signIn:
                        SignInCard(vm: vm)
                    case .signUp:
                        SignUpCard(vm: vm)
                    }
                }.transition(.push(from: .leading))
                appleButton
            }
            .animation(.snappy, value: vm.mode)
            .padding(.horizontal)
        }
    }
    
    // MARK: - Mode Selector
    private var authModeSelector: some View {
        HStack(spacing: 8) {
            ModeButton(
                title: "Sign Up",
                isSelected: vm.mode == .signUp) {
                    vm.changeAuthMode(
                        .signUp
                    )
                }
            
            ModeButton(
                title: "Sign In",
                isSelected: vm.mode == .signIn) {
                    vm.changeAuthMode(
                        .signIn
                    )
                }
        }
    }
    
    // MARK: - Apple Button
    private var appleButton: some View {
        VStack(spacing: 14) {
            Text("Or continue with:")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white.opacity(0.88))
            
            SocialButton(
                assetName: "appleIcon",
                description: "Continue with Apple",
                background: .black,
                iconSize: 22
            ) {
                // Apple Sign In
            }
        }
    }
}

// MARK: - Mode Button
private struct ModeButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(isSelected ? .myBlue : .gray)
                .fontWeight(isSelected ? .bold : .regular)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(isSelected ? .white : .white.opacity(0.65))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scaleEffect(isSelected ? 1.08 : 0.9)
                .animation(.snappy, value: isSelected)
        }
    }
}

// MARK: - Social Button
private struct SocialButton: View {
    let assetName: String
    let description: String
    let background: Color
    let iconSize: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: "applelogo")
                    .font(.title)
                    .foregroundStyle(.white)
                
                Text(description)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .foregroundStyle(.white.opacity(0.6))
            }
            .genericRoundedBackground(color: background)
        }
    }
}

#Preview {
    AuthView(
        vm: AuthViewModel(
            mode: .signIn,
            service: AuthService(),
            coordinator: AuthCoordinator(appState: AppState())
        )
    ).environment(AppCoordinator(appState: AppState()))
}
