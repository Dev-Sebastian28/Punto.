//
//  cardView.swift
//  Punto
//
//  Created by Sebastian Garcia on 16/02/26.
//

import SwiftUI

struct FormCardView: View {
    var title: String
    var text: String
    var image: String
    var action: () -> Void = {}
    private let cardStyle = LinearGradient(
        colors: [.brandBlue, .brandBlueDark],
        startPoint: .leading,
        endPoint: .trailing
    )


    var body: some View {
        VStack(alignment: .leading) {
            Button {
                action()
            } label: {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(
                            cardStyle
                        ).clipShape(.capsule)
                    
                    HStack(alignment: .top, spacing: 5) {
                        Text(text)
                            .frame(maxWidth: 270, maxHeight: 80)
                            .multilineTextAlignment(.leading)
                            .italic()
                            .foregroundStyle(Color.black)
                        
                        Spacer()
                        
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.top, -20)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.surfacePrimary)
                        .shadow(radius: 1)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.cardStroke, lineWidth: 1)
                        }
                }
            }
        }
    }
}

#Preview {
    FormCardView(
        title: "Coordinator",
        text: "You own or manage multiple vehicles but do not drive them yourself.",
        image: "manager"
    )
}
