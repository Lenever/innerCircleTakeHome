//
//  HomeViewController.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    private func setupLayout() {
        homeLabel.text = Constants.homeTitle
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(homeLabel)
        
        NSLayoutConstraint.activate([
            homeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            homeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            homeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
