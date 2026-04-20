//
//  SignInCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//

import SwiftUI

struct SignInCard: View {
    @Environment(NavigationRouter.self) var router
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Sign In")
                    .font(.system(.title2, design: .default , weight: .bold))
                    .foregroundStyle(.primary)
                
                Text("Use your credentials to access the next onboarding screen.")
                    .font(.system(.subheadline, design: .rounded, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            
            TextFieldComp(text: $email, prompt: "Email", image: "plus", color: .myBlue)
            SecureInputField(title: "Password", binding: $password, prompt: "Make it strong")
            
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
            
            DButtonComp(
                text: "Sign In to Punto",
                color: .myBlue,
                image: "arrow.right.circle.fill",
                isEnabled: !email.isEmpty &&  !password.isEmpty
            ) {
                do {
                    try AuthValidator().validate(email: email, password: password)
                    alertMessage = ""
                    showAlert = false
                    router.showMainTabs()

                } catch let error as ValidatorError {
                    alertMessage = error.suggestion
                    showAlert = true
                } catch {
                    alertMessage = "Unexpected error"
                    showAlert = true
                }
            }
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    SignInCard(showAlert: .constant(false), alertMessage: .constant(""))
        .environment(NavigationRouter())
}
