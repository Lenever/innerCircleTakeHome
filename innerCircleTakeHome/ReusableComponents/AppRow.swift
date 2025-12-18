//
//  AppRow.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 18/12/2025.
//

import UIKit
import SnapKit

import SwiftUI

struct AppRowRepresentable: UIViewRepresentable {
    var title: String
    var detail: String

    func makeUIView(context: Context) -> AppRow {
        return AppRow()
    }

    func updateUIView(_ uiView: AppRow, context: Context) {
        uiView.configure(title: title, detail: detail)
    }
}

class AppRow: UIView {
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        titleLabel.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        detailLabel.font = .preferredFont(forTextStyle: .body)

        addSubview(titleLabel)
        addSubview(detailLabel)

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        detailLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    func configure(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
}
