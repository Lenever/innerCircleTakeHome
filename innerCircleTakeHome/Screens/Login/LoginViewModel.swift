//
//  LoginViewModel.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import Combine
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var user = User.shared
    @Published var isEmailValid: Bool = false
    
    private var coordinator = Coordinator.shared
    private var mockAuth = MockAuth()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        user.$email
            .map { email in
                guard let email else { return false }
                return email.contains("@") && email.contains(".")
            }
            .assign(to: &$isEmailValid)
    }
    
    func processContinue() {
        guard let email = user.email, isEmailValid else { return }
        
        if MockAuth.getLoggedEmails().contains(email) {
            coordinator.show(.home)
        } else {
            MockAuth.saveEmail(email)
            coordinator.show(.onboarding)
        }
    }
}
