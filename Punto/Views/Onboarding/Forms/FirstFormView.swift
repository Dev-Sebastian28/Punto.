//
//  FormView.swift
//  RutaManager
//
//  Created by Sebastian Garcia on 13/02/26.
//
import SwiftUI

private enum FirstFormAnswer {
    case ownerOperator
    case cordinator
    case contractedDriver
    case other
    
    var response: String {
        switch self {
        case .ownerOperator:
            return "owner_operator"
        case .cordinator:
            return "cordinator"
        case .contractedDriver:
            return "contracted_driver"
        case .other:
            return "other"
        }
    }
}

struct FirstFormView: View {
    @Environment(NavigationRouter.self) var router
    let vm = OnboardingFormsViewModel(path: .form1)
    var body: some View {
        ZStack {
            VStack (alignment: .center, spacing: 10) {
                
                header
                    .padding(.bottom)
                
                FormCardView(
                    title: "Owner-Operator",
                    text: "You own the vehicle and you are the primary driver.",
                    image: "singleDriver") {
                        let answer: String = FirstFormAnswer.ownerOperator.response
                        vm.sendAnswer(answer)
                        router.navigate(to: .form2)
                    }
                
                FormCardView(
                    title: "Coordinator",
                    text: "You own or manage multiple vehicles but do not drive them yourself.",
                    image: "manager") {
                        let answer: String = FirstFormAnswer.cordinator.response
                        vm.sendAnswer(answer)
                        router.navigate(to: .form2)
                        
                    }
                
                FormCardView(
                    title: "Contracted Driver",
                    text: "You drive a vehicle owned by a fleet owner or a company.",
                    image: "driver") {
                        let answer: String = FirstFormAnswer.contractedDriver.response
                        vm.sendAnswer(answer)
                        router.navigate(to: .form2)
                    }
                
                otherButton
                
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
    private var otherButton: some View {
        Button {
            let answer: String = FirstFormAnswer.other.response
            vm.sendAnswer(answer)
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
    }
}




#Preview {
    FirstFormView()
        .environment(NavigationRouter())
}
