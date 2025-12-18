//
//  AppButtonRepresentable.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 18/12/2025.
//

import UIKit
import SwiftUI

struct AppButtonRepresentable: UIViewRepresentable {
    var title: String
    var isValid: Bool
    var action: () -> Void
    
    func makeUIView(context: Context) -> AppButton {
        let button = AppButton()
        button.configure(title: title)
        
        button.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didTapButton),
            for: .touchUpInside
        )
        
        return button
    }
    
    func updateUIView(_ uiView: AppButton, context: Context) {
        uiView.configure(title: title)
        uiView.setValidationState(isValid: isValid)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    class Coordinator: NSObject {
        var action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        @objc func didTapButton() {
            action()
        }
    }
}

class AppButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyles()
    }
    
    private func setupStyles() {
        self.backgroundColor = .systemBlue
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = Constants.cornerRadius
        self.titleLabel?.font = .systemFont(ofSize: Constants.buttonTitleFontSize, weight: .semibold)
        
        self.isEnabled = false
        self.alpha = 0.5
    }
    
    func configure(title: String) {
        self.setTitle(title, for: .normal)
    }
    
    func setValidationState(isValid: Bool) {
        self.isEnabled = isValid
        self.alpha = isValid ? 1.0 : 0.5
    }
}

