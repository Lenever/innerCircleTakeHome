//
//  AppTextFieldRepresentable.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import Combine
import UIKit
import SwiftUI

struct AppTextFieldRepresentable: UIViewRepresentable {
    let title: String
    let placeholder: String
    @Binding var text: String?

    func makeUIView(context: Context) -> AppTextField {
        let customField = AppTextField()
        customField.configure(title: title, placeholder: placeholder)
        customField.textField.delegate = context.coordinator
        return customField
    }

    func updateUIView(_ uiView: AppTextField, context: Context) {
        uiView.textField.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: AppTextFieldRepresentable
        init(_ parent: AppTextFieldRepresentable) { self.parent = parent }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}

class AppTextField: UIView {
    private let titleLabel = UILabel()
    let textField = UITextField()
    
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
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField])
        stack.axis = .vertical
        stack.spacing = 8
        
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(title: String, placeholder: String) {
        self.title = title
        self.textField.placeholder = placeholder
    }
    
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
