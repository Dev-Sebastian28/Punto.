//
//  TextFieldLabel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/03/26.
//
import SwiftUI

struct TextFieldComp: View {
    @Binding var text: String
    var prompt: String
    var leadingIcon: String
    var trailingIcon: String? = nil
    var trailingAction: (() -> Void)? = nil
    var color: Color = .secondary
    var isAdaptive: Bool = true
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 10) {
                Image(systemName: leadingIcon)
                    .imageScale(.medium)
                    .foregroundStyle(errorMessage != nil ? .red : color)

                TextField("", text: $text, prompt: Text(prompt))
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(autocapitalization)
                    .fixedSize(horizontal: false, vertical: true)

                if let trailing = trailingIcon {
                    Button(action: { trailingAction?() }) {
                        Image(systemName: trailing)
                            .foregroundStyle(color)
                    }
                }
            }
            .padding(.vertical, isAdaptive ? 12 : 8)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(color.opacity(0.2))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(errorMessage != nil ? .red : .clear, lineWidth: 1.5)
            )

            if let error = errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(.horizontal, 4)
            }
        }
    }
    
    // Init normal (String)
        init(text: Binding<String>, prompt: String, leadingIcon: String,
             trailingIcon: String? = nil, trailingAction: (() -> Void)? = nil,
             color: Color = .secondary, isAdaptive: Bool = true,
             keyboardType: UIKeyboardType = .default,
             autocapitalization: TextInputAutocapitalization = .sentences,
             errorMessage: String? = nil) {
            self._text = text
            self.prompt = prompt
            self.leadingIcon = leadingIcon
            self.trailingIcon = trailingIcon
            self.trailingAction = trailingAction
            self.color = color
            self.isAdaptive = isAdaptive
            self.keyboardType = keyboardType
            self.autocapitalization = autocapitalization
            self.errorMessage = errorMessage
        }

        // ✅ Init para Int — convierte automáticamente
        init(intValue: Binding<Int>, prompt: String, leadingIcon: String,
             trailingIcon: String? = nil, trailingAction: (() -> Void)? = nil,
             color: Color = .secondary, isAdaptive: Bool = true,
             errorMessage: String? = nil) {
            self._text = Binding(
                get: { intValue.wrappedValue == 0 ? "" : "\(intValue.wrappedValue)" },
                set: { intValue.wrappedValue = Int($0) ?? intValue.wrappedValue }
            )
            self.prompt = prompt
            self.leadingIcon = leadingIcon
            self.trailingIcon = trailingIcon
            self.trailingAction = trailingAction
            self.color = color
            self.isAdaptive = isAdaptive
            self.keyboardType = .numberPad      // Siempre numberPad para Int
            self.autocapitalization = .never
            self.errorMessage = errorMessage
        }
}

#Preview {
    TextFieldComp(text: .constant(""), prompt: "Hello", leadingIcon: "plus")
}
