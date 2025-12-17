//
//  LoginViewModel.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import Combine
import Foundation

class LoginViewModel {
    @Published var emailText: String = ""
    @Published var isEmailValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Observe changes to emailText and validate
        $emailText
            .map { email in
                return email.contains("@") && email.contains(".")
            }
            .assign(to: &$isEmailValid)
    }
    
    func processContinue() {
        guard isEmailValid else { return }
        Coordinator.shared.show(.onboarding)
    }
}
