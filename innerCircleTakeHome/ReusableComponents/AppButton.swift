//
//  AppButton.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import UIKit
import SnapKit

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
        self.layer.cornerRadius = 12
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        
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
