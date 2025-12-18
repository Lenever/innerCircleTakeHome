//
//  Untitled.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 18/12/2025.
//

import UIKit

class ToggleComponent: UIView {
    private let label = UILabel()
    private let iconView = UIImageView()
    private let stackView = UIStackView()
    
    var isOn: Bool = false {
        didSet { updateAppearance() }
    }
    
    var title: String? {
        didSet { label.text = title }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        layer.cornerRadius = Constants.cornerRadius
        
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(iconView)
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        label.textColor = .white
        backgroundColor = isOn ? .systemBlue : UIColor.systemBlue.withAlphaComponent(0.3)
        let config = UIImage.SymbolConfiguration(weight: .bold)
        iconView.image = UIImage(systemName: isOn ? "plus" : "xmark", withConfiguration: config)
        iconView.tintColor = .white
    }
}

import SwiftUI

struct ToggleComponentRepresentative: UIViewRepresentable {
    let title: String
    @Binding var isOn: Bool

    func makeUIView(context: Context) -> ToggleComponent {
        let view = ToggleComponent()
        view.title = title
        
        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
        view.addGestureRecognizer(tap)
        
        return view
    }

    func updateUIView(_ uiView: ToggleComponent, context: Context) {
        uiView.isOn = isOn
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: ToggleComponentRepresentative
        init(_ parent: ToggleComponentRepresentative) { self.parent = parent }

        @objc func handleTap() {
            withAnimation(.spring()) {
                parent.isOn.toggle()
            }
        }
    }
}
