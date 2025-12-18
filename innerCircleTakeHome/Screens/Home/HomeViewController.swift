//
//  HomeViewController.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//


import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.homeTitle
        label.font = .systemFont(ofSize: Constants.homeTitleFontSize, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.stackViewSpacing
        stack.alignment = .fill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(userImage)
        view.addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().inset(Constants.viewInsets)
            make.trailing.equalToSuperview().inset(Constants.viewInsets)
        }
        
        userImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.viewInsets)
            make.leading.trailing.equalToSuperview().inset(Constants.viewInsets)
            make.height.equalTo(Constants.homeImageHeight)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(Constants.viewInsets)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    private func configureData() {
        userImage.image = viewModel.user.photo
        
        for item in viewModel.user.confirmationDetails {
            let row = AppRow()
            row.configure(title: item.0, detail: item.1)
            contentStackView.addArrangedSubview(row)
        }
    }
}
