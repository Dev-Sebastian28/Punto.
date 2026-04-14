//
//  ContentView.swift
//  RouteManager
//
//  Created by Sebastian Garcia on 11/02/26.
//

import SwiftUI

private enum AuthMode {
    case signUp
    case signIn
}

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showPassword = false
    @State private var authMode: AuthMode = .signUp
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.myBlue, .myBlue, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                selectedWay
                
                if authMode == .signUp {
                    signUpCard
                    
                } else {
                    signInCard
                }
                socialSection
            }
            .animation(.snappy, value: authMode)
            .padding(.horizontal, 15)
            .padding(.vertical, 28)
            
                
            
            
        }.alert("Check Fields Please", isPresented: $showingAlert) {
        } message: {
            Text(alertMessage)
        }
    }
    
    private var appIntroduction: some View {
        Button {
            router.navigate(to: .appIntroduction)
        } label: {
            HStack {
                Text("Watch App Introduction")
            }
            .font(.headline)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .underline(true, pattern: .solid, color: .gray)
            
        }
    }
    
    private var selectedWay: some View {
        HStack(spacing: 50) {
            Button {
                authMode = .signUp
            } label: {
                Text("Sign Up")
                    .foregroundStyle(authMode == .signUp ? .myBlue : .gray)
                    .bold(authMode == .signUp)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 44)
                    .background(
                        authMode == .signUp ? .white : .white.opacity(0.8)
                    ).clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaleEffect(authMode == .signUp ? 1.2 : 1)
            }
            
            
            Button {
                authMode = .signIn
            } label: {
                Text("Sign In")
                    .foregroundStyle(authMode == .signIn ? .myBlue : .gray)
                    .bold(authMode == .signIn)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 44)
                    .background(
                        authMode == .signIn ? .white : .white.opacity(0.8)
                        
                    ).clipShape(
                        RoundedRectangle(cornerRadius: 10)
                        
                    )
                
                    .scaleEffect(authMode == .signIn ? 1.2 : 1)
                
            }
        }
    }
    
    private var signInCard: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Sign In")
                    .font(.system(.title2, design: .default , weight: .bold))
                    .foregroundStyle(Color(red: 0.08, green: 0.16, blue: 0.24))
                
                Text("Use your credentials to access the next onboarding screen.")
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            
            TextFieldComp(text: $email, prompt: "Email", image: "plus", color: .myBlue)
            secureInputField(title: "Password", binding: $password, prompt: "Make it strong")
            
            HStack {
                Spacer()
                
                Button {
                    // Action for forgot password
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.primary)
                        .padding(.bottom)
                }
            }
            
            DButtonComp(text: "Sign In to Punto",color: .myBlue, image: "arrow.right.circle.fill", isEnabled: /*!email.isEmpty &&  !password.isEmpty*/true, action: continueToOnboarding)
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
    
    private var signUpCard: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Sign Up")
                .font(.system(.title2, design: .default , weight: .bold))
                .foregroundStyle(Color(red: 0.08, green: 0.16, blue: 0.24))
            
            TextFieldComp(text: $email, prompt: "Email", image: "plus", color: .myBlue)
            secureInputField(title: "Password", binding: $password, prompt: "Make it strong")
            secureInputField(title: "Confirm Password", binding: $confirmPassword, prompt: "Confirm your password")
                .padding(.bottom)
            
            DButtonComp(text: "Sign Up to Punto",color: .myBlue, image: "arrow.right", isEnabled: /*!email.isEmpty && !password.isEmpty*/true, action: continueToOnboarding)
            
            appIntroduction
            
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
    
    private func secureInputField(title: String, binding: Binding<String>, prompt: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color(red: 0.12, green: 0.17, blue: 0.24))
            
            HStack(spacing: 12) {
                Image(systemName: "lock.fill")
                    .foregroundStyle(.black)
                    .frame(width: 20)
                
                Group {
                    if showPassword {
                        TextField("", text: binding, prompt: Text(prompt))
                            .textContentType(.password)
                    } else {
                        SecureField("", text: binding, prompt: Text(prompt))
                            .textContentType(.password)
                    }
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                        .foregroundStyle(.gray.opacity(0.5))
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(.blue.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
    
    private var socialSection: some View {
        VStack(spacing: 14) {
            Text("Or continue with:")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white.opacity(0.88))
            
            VStack(spacing: 18) {
                socialButton(assetName: "googleIcon", background: .white, iconSize: 28, description: "Continue with Google")
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
    
    private func continueToOnboarding() {
        router.navigate(to: .form1)
        
        
        //        if authMode == .signUp, password != confirmPassword {
        //            alertMessage = "Passwords do not match"
        //            showingAlert = true
        //            return
        //        }
        //
        //        do {
        //            try AuthValidator().validate(email: email, password: password)
        //            alertMessage = ""
        //            showingAlert = false
        //        } catch let error as ValidatorError {
        //            alertMessage = error.suggestion
        //            showingAlert = true
        //        } catch {
        //            alertMessage = "Unexpected error"
        //            showingAlert = true
        //        }
    }
}

#Preview {
    SignInView()
        .environment(NavigationRouter())
}
