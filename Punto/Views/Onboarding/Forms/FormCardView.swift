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


    var body: some View {
        VStack(alignment: .leading) {
            Button {
                action()
            } label: {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(
                            LinearGradient(
                                colors: [.brandBlue, .brandBlueDark],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(.capsule)
                    
                    HStack(alignment: .top, spacing: 5) {
                        
                        Text(text)
                            .frame(maxWidth: 270, maxHeight: 80, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .italic()
                            .foregroundStyle(Color.textMuted)
                        
                        Spacer()
                        
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.top, -20)
                            
                    }
                }
                .padding(10)
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
    FormCardView(title: "Coordinator", text: "You own or manage multiple vehicles but do not drive them yourself.", image: "manager")
}
