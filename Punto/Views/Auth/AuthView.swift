//
//  AuthView.swift
//  Punto
//

import SwiftUI

struct AuthView: View {
    @State private var vm = AuthViewModel(
        mode: .signUp,
        service: AuthService()
    )
    @Environment(NavigationRouter.self) var router

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.myBlue, .white, .myBlue],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 25) {
                modeSelector

                Group {
                    if vm.mode == .signUp {
                        SignUpCard(vm: vm)
                    } else {
                        SignInCard(vm: vm)
                    }
                }.transition(.push(from: .leading))

                socialSection
            }
            .animation(.snappy, value: vm.mode)
            .padding(.horizontal, 15)
            .padding(.vertical, 28)
        }
        .onChange(of: vm.authStatus) { _, newStatus in
            // If the user had a succefuel operation and its his first time go to onboaerding
            if newStatus == .authenticated && vm.mode == .signUp {
                router.navigate(to: .form1)
            }
            
            // If the user had a succefuel operation and its not his first time go to maintabs

            else if newStatus == .authenticated && vm.mode == .signIn {
                router.showMainTabs()
            }
        }
    }

    // MARK: - Mode Selector

    private var modeSelector: some View {
        HStack(spacing: 8) {
            ModeButton(title: "Sign Up", isSelected: vm.mode == .signUp) {
                vm.setMode(.signUp)
            }
            ModeButton(title: "Sign In", isSelected: vm.mode == .signIn) {
                vm.setMode(.signIn)
            }
        }
    }

    // MARK: - Social

    private var socialSection: some View {
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
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
    }
}

#Preview {
    AuthView()
        .environment(NavigationRouter())
}
