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
        VStack {
            TabView(selection: $viewModel.currentStep) {
                intro.tag(OnboardingStep.intro)
                name.tag(OnboardingStep.name)
                photo.tag(OnboardingStep.photo)
                social.tag(OnboardingStep.social)
                job.tag(OnboardingStep.job)
                lifestyle.tag(OnboardingStep.lifestyles)
                confirmation.tag(OnboardingStep.confirmation)
            }
            .tabViewStyle(.page)
            continueButton
        }
        .padding(24)
        .fullScreenCover(isPresented: $viewModel.isShowingCamera) {
            ImagePicker(selectedImage: $viewModel.user.photo)
                .ignoresSafeArea()
        }
    }
    
    var intro: some View {
        Text("Share a bit more about yourself/n\(viewModel.user.email ?? "")")
            .font(.title)
    }
    
    @ViewBuilder
    var name: some View {
        AppTextFieldRepresentable(title: Constants.nameTitle, placeholder: Constants.namePlaceholder, text: $viewModel.user.name)
            .frame(height: 100)
    }
    
    @ViewBuilder
    var photo: some View {
        VStack {
            Text(Constants.imageTitle)
                .font(Font.title3.bold())
            
            if let image = viewModel.user.photo {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Color.green
                    .frame(width: 400, height: 400)
            }
        }
        .onTapGesture {
            viewModel.isShowingCamera.toggle()
        }
    }
    
    @ViewBuilder
    var social: some View {
        AppTextFieldRepresentable(title: Constants.socialsTitle, placeholder: Constants.socialsTitle, text: $viewModel.user.social)
            .frame(height: 100)
    }
    
    @ViewBuilder
    var job: some View {
        AppTextFieldRepresentable(title: Constants.jobTitle, placeholder: Constants.jobPlaceholder, text: $viewModel.user.job)
            .frame(height: 100)
    }
    
    @ViewBuilder
    var lifestyle: some View {
        Text(Constants.lifestyleTitle)
    }
    
    @ViewBuilder
    var confirmation: some View {
        VStack {
            ForEach(viewModel.user.confirmationDetails, id: \.0) { detail in
                AppRowRepresentable(title: detail.0, detail: detail.1)
            }
        }
        Text(Constants.confirmationTitle)
    }
    
    var continueButton: some View {
        AppButtonRepresentable(title: viewModel.continueButtonTitle, isValid: true) {
            viewModel.moveToNextStep()
        }
        .frame(height: 50)
    }
}
