//
//  MainCollectionViewCell.swift
//  Dispo Take Home
//
//  Created by Ikechukwu Onuorah on 15/01/2022.
//

import Kingfisher
import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    var gifDetail: GifObject? {
        didSet {
            guard let detail = gifDetail else { return }
            self.activityIndicator.startAnimating()
            gifTitle.text = detail.title
            gifThumbNail.kf.setImage(with: detail.images.fixed_height.url, completionHandler:  { _ in
                self.activityIndicator.stopAnimating()
            })
        }
    }
    
    private var viewContainer = UIView()
    private var gifTitle = UILabel()
    private var gifThumbNail = UIImageView()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    func setupViewContainer() {
        addSubview(viewContainer)
        viewContainer.clipsToBounds = true
        viewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func setupGifThumbNail() {
        gifThumbNail.addSubview(activityIndicator)
        viewContainer.addSubview(gifThumbNail)
        gifThumbNail.contentMode = .scaleAspectFill
        gifThumbNail.clipsToBounds = true
        gifThumbNail.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(75)
            make.centerY.equalTo(viewContainer)
            make.leading.equalTo(viewContainer).offset(15)
        }
    }
    
    func setupGifTitle() {
        viewContainer.addSubview(gifTitle)
        gifTitle.numberOfLines = 0
        gifTitle.lineBreakMode = .byWordWrapping
        gifTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(gifThumbNail.snp.trailing).offset(25)
            make.trailing.equalTo(viewContainer).offset(-25)
            make.centerY.equalTo(gifThumbNail)
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(gifThumbNail)
            make.centerY.equalTo(gifThumbNail)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    func layoutViews() {
        setupViewContainer()
        setupGifThumbNail()
        setupGifTitle()
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
