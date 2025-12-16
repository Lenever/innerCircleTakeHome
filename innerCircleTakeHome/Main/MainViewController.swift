import UIKit

class MainViewController: UIViewController {
    private let customCellIdentifier = Constants.customCellIdentifier
    private var viewModel = MainViewModel()
    private var gifs: APIListResponse?
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(activityIndicator)
        setupActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTrendingGifs()
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search gifs..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private var layout: UICollectionViewLayout {
        // TODO: implement
        let _layout = UICollectionViewFlowLayout()
        _layout.itemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 90)
        _layout.scrollDirection = .vertical
        _layout.minimumInteritemSpacing = 0.0
        return _layout
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        return collectionView
    }()
    
    func setupActivityIndicator() {
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
    }
    
    func loadTrendingGifs() {
        activityIndicator.startAnimating()
        viewModel.fetchTrendingGifs(
            success: { trendingGifs in
              self.gifs = trendingGifs
              DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
              }
                print(trendingGifs)
            },
            failure: { error in
                print(error)
            }
        )
    }
}

// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: implement
        if searchText.isEmpty {
            loadTrendingGifs()
        } else {
            self.collectionView.isHidden = true
            self.activityIndicator.startAnimating()
            DispatchQueue.main.async {
                self.viewModel.fetchSearchGifs(
                    word: searchText,
                    success: { trendingGifs in
                        DispatchQueue.main.async {
                            self.gifs = trendingGifs
                            self.activityIndicator.stopAnimating()
                            self.collectionView.isHidden = false
                            self.collectionView.reloadData()
                        }
                        print(trendingGifs)
                    },
                    failure: { error in
                        print(error)
                    }
                )
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gifs?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as? MainCollectionViewCell else { fatalError(Constants.fatalError) }
        let gif = gifs?.data[indexPath.row]
        customCell.gifDetail = gif
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let gifId = gifs?.data[indexPath.row].id else { return }
        let viewController = DetailViewController()
        viewController.gifId = gifId
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
