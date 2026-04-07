//
//  AddDriverForm.swift
//  Punto
//
//  Created by Sebastian Garcia on 10/03/26.
//

import SwiftUI

struct AddDriverForm: View {
    let index: Int
    @Binding var isPresented: Bool
    @State private var mail: String = ""
    @State private var name: String = ""
    @State private var number: String = ""

    var body: some View {
        VStack(spacing: 6) {
            TextFieldComponent(text: $name, prompt: "Driver Name", image: "person.fill", isRequired: false)
                .padding(.bottom, 8)

            TextFieldComponent(text: $number, prompt: "Driver Phone Number", image: "number", isRequired: true)

            TextFieldComponent(text: $mail, prompt: "Driver Mail", image: "at", isRequired: true)

            HStack {
                DominantButtonView(
                    text: "Cancel",
                    color: .gray,
                    image: "x.circle.fill",
                    style: .neutral,
                    maxWidth: 120
                ) {
                    isPresented.toggle()
                }
                .padding(.top, 30)

                DominantButtonView(
                    text: "Send Invitation",
                    color: .blue,
                    image: "paperplane.fill",
                    maxWidth: 200,
                    isEnabled: !number.isEmpty
                ) {
                }
                .padding(.top, 30)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    AddDriverForm(index: 1, isPresented: .constant(true))
}
