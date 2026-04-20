//
//  SecureInputField.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/04/26.
//
import SwiftUI
struct SecureInputField: View {
    let title: String
    var binding: Binding<String>
    let prompt: String
    @State private var showPassword: Bool = false
    
    var body: some View {
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
}
