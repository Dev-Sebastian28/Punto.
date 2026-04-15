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
                
                FormCardView(
                    title: "Gig / Rental Driver",
                    text: "Personal or rented vehicles used for apps and delivery services.",
                    image: "transportation") {
                    router.navigate(to: .addVehicle)
                }
                
                
                FormCardView(
                    title: "Heavy Logistics",
                    text: "Large vehicles dedicated to heavy cargo and long-haul freight.",
                    image: "privateCar") {
                    router.navigate(to: .addVehicle)
                }
                
                
                Button {
                    router.navigate(to: .addVehicle)
                } label: {
                    Text("Other")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .bold()
                        .padding(.horizontal, 60)
                        .padding(.vertical, 10)
                        .background(
                            LinearGradient(
                                colors: [.brandBlue, .brandBlueDark],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .clipShape(.capsule)
                            .shadow(color: .myBlue, radius: 3)
                            
                        )
                }
                                
                Spacer()
            }.padding(.horizontal, 10)
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("What type of vehile/s do you drive?")
                .font(.title2)
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
