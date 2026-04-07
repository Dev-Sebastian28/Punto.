//
//  ContentView.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/02/26.
//

import SwiftUI
import Observation

struct SecondFormView: View {
    @Environment(NavigationRouter.self) var router

    var body: some View {
        ZStack {
            VStack (alignment: .center, spacing: 7) {
                
                header
                    .padding(.bottom)
                
                FormCardView(title: "Gig / Rental Driver", text: "Personal or rented vehicles used for apps and delivery services.", image: "transportation") {
                    router.navigate(to: .addVehicle)
                }
                
                
                FormCardView(title: "Heavy Logistics", text: "Large vehicles dedicated to heavy cargo and long-haul freight.", image: "privateCar") {
                    router.navigate(to: .addVehicle)
                }
                
                
                Text("Other")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.horizontal, 60)
                    .padding(.vertical, 10)
                    .background(
                        Color.myBlue
                        .clipShape(.capsule)
                        .shadow(color: .myBlue, radius: 3)
                        
                    )
                    .padding(.top)
                
                Spacer()
            }.padding(.horizontal, 10)
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("What type of role are you?")
                .font(.largeTitle)
                .bold()
            Text("This choice will not affect your experience")
                .font(Font.subheadline.italic())
                .foregroundStyle(.gray)
                .underline()
        }
    }
}


#Preview {
    SecondFormView()
        .environment(NavigationRouter())
}
