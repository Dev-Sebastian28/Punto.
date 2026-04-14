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
    var image: String
    var color: Color = .secondary
    var isRequired: Bool = false
    
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
            .frame(height: 48)
            .background {
                color.opacity(0.2)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)
            }
        }
    }
}

#Preview {
    TextFieldComp(text: .constant("Volvo"), prompt: "Vehicle Brand", image: "plus", isRequired: true)
}
