//
//  OnboardingViewModel.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import Foundation

enum OnboardingStep {
    case intro, social, name, job, lifestyles, confirmation
}

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: OnboardingStep = .intro
    @Published var biking: String = ""

    var onCompletion: (() -> Void)?
    
    func next() {
        // Logic to move between steps
        if currentStep == .confirmation {
            onCompletion?() // Notify the Coordinator to switch to UIKit Home
        }
    }
}
