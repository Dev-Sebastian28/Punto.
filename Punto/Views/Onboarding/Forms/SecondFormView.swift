//
//  ContentView.swift
//  Punto
//
//  Created by Sebastian Garcia on 15/02/26.
//

import SwiftUI


private enum SecondFormAnswer {
    case heavyLogistics
    case privateVehicles
    case other
    
    var response: String {
        switch self {
        case .heavyLogistics:
            return "heavy_logistics"
        case .privateVehicles:
            return "private_vehicles"
        case .other:
            return "other"
        }
    }
}

struct SecondFormView: View {
    let vm = OnboardingFormsViewModel(path: .form2)
    @Environment(AppCoordinator.self) var coordinator

    
    var body: some View {
        ZStack {
            VStack (alignment: .center, spacing: 7) {
                
                header
                    .padding(.bottom)
                
                FormCardView(
                    title: "Gig / Rental Driver",
                    text: "Personal or rented vehicles used for apps and delivery services.",
                    image: "privateCar") {
                        let answer: String = SecondFormAnswer.heavyLogistics.response
                        vm.sendAnswer(answer)
                        coordinator.onBoardingCoordinator.navigate(to: .addVehicle)
                    }
                
                
                FormCardView(
                    title: "Heavy Logistics",
                    text: "Large vehicles dedicated to heavy cargo and long-haul freight.",
                    image: "transportation") {
                        let answer: String = SecondFormAnswer.privateVehicles.response
                        vm.sendAnswer(answer)
                        coordinator.onBoardingCoordinator.navigate(to: .addVehicle)

                    }
                
                
                Button {
                    let answer: String = SecondFormAnswer.other.response
                    vm.sendAnswer(answer)
                    coordinator.onBoardingCoordinator.navigate(to: .addVehicle)

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
        .environment(AppCoordinator(appState: AppState()))
}
