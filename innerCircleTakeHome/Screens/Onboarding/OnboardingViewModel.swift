//
//  OnboardingViewModel.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import Foundation

enum OnboardingStep {
    case intro, name, photo, social, job, lifestyles, confirmation
}

final class OnboardingViewModel: ObservableObject {
    @Published var user = User.shared
    @Published var currentStep: OnboardingStep = .intro
    @Published var isShowingCamera: Bool = false
    
    private var coordinator = Coordinator.shared
    var continueButtonTitle: String {
        currentStep == .confirmation ? "Looks good!" : "Next"
    }

    var onCompletion: (() -> Void)?
    
    func moveToNextStep() {
        switch currentStep {
        case .intro: currentStep = .name
        case .name: currentStep = .photo
        case .photo: currentStep = .social
        case .social: currentStep = .job
        case .job: currentStep = .lifestyles
        case .lifestyles: currentStep = .confirmation
        case .confirmation: coordinator.show(.home)
        }
    }
}
