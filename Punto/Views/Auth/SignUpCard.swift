//
//  SignUpCard.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//

import SwiftUI

struct SignUpCard: View {
    @Environment(NavigationRouter.self) var router
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Sign Up")
                .font(.system(.title2, design: .default , weight: .bold))
                .foregroundStyle(.primary)
            
            TextFieldComp(text: $email, prompt: "Email", image: "plus", color: .myBlue)
            SecureInputField(title: "Password", binding: $password, prompt: "Make it strong")
            SecureInputField(title: "Confirm Password", binding: $confirmPassword, prompt: "Confirm your password")
                .padding(.bottom)
            
            DButtonComp(
                text: "Sign Up to Punto",
                color: .myBlue,
                image: "arrow.right",
                isEnabled: !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
            ) {
                do {
                    try AuthValidator().validate(email: email, password: password)
                    alertMessage = ""
                    showAlert = false
                    router.navigate(to: .form1)

                } catch let error as ValidatorError {
                    alertMessage = error.suggestion
                    showAlert = true
                } catch {
                    alertMessage = "Unexpected error"
                    showAlert = true
                }
            }
            
            appIntroduction
            
        }
        .padding(22)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
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
}

#Preview {
    SignUpCard(showAlert: .constant(true), alertMessage: .constant(""))
        .environment(NavigationRouter())
}
