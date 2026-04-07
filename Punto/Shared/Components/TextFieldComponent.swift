//
//  TextFieldLabel.swift
//  Punto
//
//  Created by Sebastian Garcia on 19/03/26.
//
import SwiftUI

struct TextFieldComponent: View {
    @Binding var text: String
    var prompt: String
    var image: String
    var isRequired: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            if isRequired {
                Text("Required *")
                    .foregroundStyle(.red)
                    .bold()
            }
            HStack(spacing: 10) {
                Image(systemName: image)
                    .padding(.leading)
                TextField("", text: $text, prompt: Text(prompt))
            }
            .frame(height: 54)
            .background {
                Color(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15))

            }
        }
    }
}

#Preview {
    TextFieldComponent(text: .constant("Volvo"), prompt: "Vehicle Brand", image: "plus", isRequired: true)
}
