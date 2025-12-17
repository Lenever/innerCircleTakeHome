//
//  OnboardingView.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//
import SwiftUI

struct OnboardingView: View {
    @StateObject
    private var viewModel = OnboardingViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text(Constants.editProfileTitle)
                .font(.headline)
            
            AppTextFieldRepresentable(title: Constants.lifestyleTitle, placeholder: Constants.enterPlaceholder, text: $viewModel.biking)
                .frame(height: 50)
            
            Text("You entered: \(viewModel.biking)")
        }
        .padding()
    }
}
