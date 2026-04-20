//
//  ContentView.swift
//  RouteManager
//
//  Created by Sebastian Garcia on 11/02/26.
//

import SwiftUI

struct AuthView: View {
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var vm = AuthViewModel(mode: .signUp)
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.myBlue, .white, .myBlue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                selectedWay
                
                if vm.mode == .signUp {
                    SignUpCard(showAlert: $showingAlert, alertMessage: $alertMessage)
                    
                } else {
                    SignInCard(showAlert: $showingAlert, alertMessage: $alertMessage)
                }
                socialSection
            }
            .animation(.snappy, value: vm.mode)
            .padding(.horizontal, 15)
            .padding(.vertical, 28)

        }.alert("Check Fields Please", isPresented: $showingAlert) {
        } message: {
            Text(alertMessage)
        }
    }
        
    private var selectedWay: some View {
        HStack(spacing: 50) {
            Button {
                vm.setMode(.signUp)
                print(vm.mode)
            } label: {
                Text("Sign Up")
                    .foregroundStyle(vm.mode == .signUp ? .myBlue : .gray)
                    .bold(vm.mode == .signUp)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 44)
                    .background(
                        vm.mode == .signUp ? .white : .white.opacity(0.8)
                    ).clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaleEffect(vm.mode == .signUp ? 1.2 : 1)
            }
            
            
            Button {
                vm.setMode(.signIn)
                print(vm.mode)

            } label: {
                Text("Sign In")
                    .foregroundStyle(vm.mode == .signIn ? .myBlue : .gray)
                    .bold(vm.mode == .signIn)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 44)
                    .background(
                        vm.mode == .signIn ? .white : .white.opacity(0.8)
                        
                    ).clipShape(
                        RoundedRectangle(cornerRadius: 10)
                        
                    )
                
                    .scaleEffect(vm.mode == .signIn ? 1.2 : 1)
                
            }
        }
    }
  
    private var socialSection: some View {
        VStack(spacing: 14) {
            Text("Or continue with:")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white.opacity(0.88))
            
            VStack(spacing: 18) {
                socialButton(assetName: "appleIcon", background: .black, iconSize: 48, description: "Continue with Apple")
            }
        }
    }
    private func socialButton(assetName: String, background: Color, iconSize: CGFloat, description: String) -> some View {
        HStack {
            Button {
                // Social Auth logic
            } label: {
                Text(description)
                    .font(.title3.bold())
                    .foregroundStyle(background == .black ?  .white : .gray)
                Circle()
                    .fill(background)
                    .frame(width: 68, height: 68)
                    .overlay {
                        Image(assetName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                    }
            }
            .padding(.horizontal, 30)
            .background {
                background
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
        }
    }
    
}

#Preview {
    AuthView()
        .environment(NavigationRouter())
}
