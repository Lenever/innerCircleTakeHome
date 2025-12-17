//
//  LoginViewController.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import UIKit
import SnapKit
import Combine

class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private var isEmailValid: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.continueButton.isEnabled = self.isEmailValid
                self.continueButton.alpha = self.isEmailValid ? 1.0 : 0.5
            }
        }
    }
    
    private var titleLabel = UILabel()
    private var emailField = AppTextField()
    private var continueButton = AppButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutSubviews()
        bindViewModel()
    }
    
    func layoutSubviews() {
        setupTitleLabel()
        setupEmailField()
        setupContinueButton()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = Constants.loginTitle
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(Constants.horizontalPadding)
            make.trailing.equalTo(view).offset(-Constants.horizontalPadding)
        }
    }
    
    func setupEmailField() {
        view.addSubview(emailField)
        emailField.configure(title: Constants.emailTitle, placeholder: Constants.emailPlaceholder)
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalTo(view).offset(24)
            make.trailing.equalTo(view).offset(-24)
        }
    }
    
    func setupContinueButton() {
        view.addSubview(continueButton)
        continueButton.configure(title: Constants.nextTitle)
        continueButton
            .addTarget(
                self,
                action: #selector(didTapContinue),
                for: .touchUpInside
            )
        
        continueButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(view).offset(24)
            make.trailing.equalTo(view).offset(-24)
            make.height.equalTo(50)
        }
    }
    
    private func bindViewModel() {
        emailField.textPublisher
            .assign(to: \.emailText, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.$isEmailValid
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                self?.isEmailValid = isValid
            }
            .store(in: &cancellables)
    }
    
    @objc private func didTapContinue() {
        viewModel.processContinue()
    }
}
