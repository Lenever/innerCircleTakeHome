import UIKit

class DetailViewController: UIViewController {
    private var viewModel = DetailViewModel()
    var gifId: String? {
        didSet {
            loadGif(gifId: gifId ?? String())
        }
    }
    private var gifInfo: GifObject? {
        didSet {
            guard let detail = gifInfo else { return }
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.titleLabel.text = detail.title
                self.sourceLabel.text = detail.source_tld
                self.ratingLabel.text = detail.rating
                self.imageView.kf.setImage(with: detail.images.fixed_height.url, completionHandler:  { _ in
                    self.activityIndicator.stopAnimating()
                })

            }
        }
    }
    
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var sourceLabel = UILabel()
    private var ratingLabel = UILabel()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutSubviews()
        loadGif(gifId: gifId ?? String())
    }
    
    func layoutSubviews() {
        setupNavigationBar()
        setupImageView()
        setuptitleLabel()
        setupSourceLabel()
        setupRatingLabel()
        setupActivityIndicator()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = Constants.detailTitle
    }
    
    func setupImageView() {
        imageView.addSubview(activityIndicator)
        view.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(25)
            make.trailing.equalTo(view).offset(-25)
            make.height.equalTo(view).multipliedBy(0.3)
        }
    }
    
    func setuptitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.leading.equalTo(view).offset(25)
            make.trailing.equalTo(view).offset(-25)
        }
    }
    
    func setupSourceLabel() {
        view.addSubview(sourceLabel)
        sourceLabel.numberOfLines = 0
        sourceLabel.lineBreakMode = .byWordWrapping
        sourceLabel.textAlignment = .center
        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(view).offset(25)
            make.trailing.equalTo(view).offset(-25)
        }
    }
    
    func setupRatingLabel() {
        view.addSubview(ratingLabel)
        ratingLabel.numberOfLines = 0
        ratingLabel.lineBreakMode = .byWordWrapping
        ratingLabel.textAlignment = .center
        ratingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sourceLabel.snp.bottom).offset(25)
            make.leading.equalTo(view).offset(25)
            make.trailing.equalTo(view).offset(-25)
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.centerY.equalTo(imageView)
        }
    }
    
    func loadGif(gifId: String) {
        viewModel.fetchGif(
            gifId: gifId,
            success: { gifInfo in
                self.gifInfo = gifInfo.data
            },
            failure: { error in
                print(error)
            }
        )
    }    
}
