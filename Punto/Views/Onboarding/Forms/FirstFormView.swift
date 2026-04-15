//
//  FormView.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//
import SwiftUI

struct FirstFormView: View {
    @Environment(NavigationRouter.self) var router

    var body: some View {
        ZStack {
            VStack (alignment: .center, spacing: 10) {

                header
                    .padding(.bottom)
                
                FormCardView(
                    title: "Owner-Operator",
                    text: "You own the vehicle and you are the primary driver.",
                    image: "singleDriver") {
                    router.navigate(to: .form2)
                }

                FormCardView(
                    title: "Coordinator",
                    text: "You own or manage multiple vehicles but do not drive them yourself.",
                    image: "manager") {
                    router.navigate(to: .form2)
                }

                FormCardView(
                    title: "Contracted Driver",
                    text: "You drive a vehicle owned by a fleet owner or a company.",
                    image: "driver") {
                    router.navigate(to: .form2)
                }


                Button {
                    router.navigate(to: .form2)
                } label: {
                    Text("Other")
                        .font(.subheadline).bold()
                        .foregroundStyle(.white)
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
                        .padding(.top)
                }
                Spacer()
            }.padding(.horizontal, 10)
        }
    }
private var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("What type of role are you?")
                .font(.title)
                .bold()
            Text("This choice will not affect your experience")
                .font(Font.subheadline.italic())
                .foregroundStyle(.gray)
                .underline()
        }
    }
}



#Preview {
    FirstFormView()
        .environment(NavigationRouter())
}
