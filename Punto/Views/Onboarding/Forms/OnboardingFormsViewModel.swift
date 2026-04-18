//
//  OnboardingFormsViewModel.swift
//  Punto
//
//  Created by Sebastian Garcia on 18/04/26.
//
import Foundation

class OnboardingFormsViewModel {
    let path: OnBoardingFormRoute
    func sendAnswer(_ answer: String) {
        Task {
            try? await path.sendAnswe(answer)
        }
    }
    
    init(path: OnBoardingFormRoute) {
        self.path = path
    }
}
