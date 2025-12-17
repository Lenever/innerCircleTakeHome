//
//  AppTextField.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import Combine
import UIKit

class AppTextField: UIView {
    private let titleLabel = UILabel()
    let textField = UITextField()
    private let underlineView = UIView()
    
    var title: String? {
        didSet { titleLabel.text = title }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        titleLabel.font = .systemFont(ofSize: Constants.fontSize, weight: .semibold)
        titleLabel.textColor = .secondaryLabel
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField, underlineView])
        stack.axis = .vertical
        stack.spacing = 8
        
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        underlineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
    }
    
    func configure(title: String, placeholder: String) {
        self.title = title
        self.textField.placeholder = placeholder
    }
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
