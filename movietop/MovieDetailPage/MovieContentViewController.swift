//
//  MovieContentViewController.swift
//  movietop
//
//  Created by Dam Hung on 23/02/2023.
//

import UIKit

class MovieContentViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var indicatorView: UIView!
    
    @IBOutlet weak var boxIndicatorView: UIView!
    
    @IBOutlet weak var ibdmView: UIView!
    
    @IBOutlet weak var ibdmText: UILabel!
    
    @IBOutlet weak var castCollection: UICollectionView!
    
    @IBOutlet weak var overViewText: UILabel!
    
    @IBOutlet weak var moiveNameText: UILabel!
    
    @IBOutlet weak var actionText: CustomButtonView!
    
    @IBOutlet weak var ageText: CustomButtonView!
    
    @IBOutlet weak var statusText: InfoView!
    
    @IBOutlet weak var originalLanguageText: InfoView!
    
    @IBOutlet weak var budget: InfoView!
    
    @IBOutlet weak var revenueText: InfoView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    var movieId: Int = 0
    
    var listCast: [Cast] = []
    var movie: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupMenuCollectionView()
    }
    
    func loadData() {
        //        let dispatchGroup = DispatchGroup()
        //        dispatchGroup.enter()
        getMovieDetail(movieId: movieId){ movie in
            print("HungDQ movie: \(movie.voteAverage)")
            DispatchQueue.main.async{ [weak self] in
                self?.ibdmText.text = "IBDm  \(movie.voteAverage)"
                self?.moiveNameText.text = movie.title
                self?.overViewText.text = movie.overview
                self?.actionText.desc = movie.genres.first?.name ?? "Action"
                self?.ageText.desc = movie.adult ? "18+" : "10+"
                self?.statusText.desc = movie.status
                self?.originalLanguageText.desc = movie.originalLanguage
                self?.revenueText.desc = "\(movie.revenue)"
                self?.budget.desc = "\(movie.budget)"
                self?.movieImage.load(url: URL(string: baseImageUrl + movie.posterPath )!)
                self?.reloadInputViews()
            }
            
            
        }
        //        dispatchGroup.leave()
        //
        //        dispatchGroup.enter()
        getMovieCredits(movieId: movieId){ [weak self] movieCredits in
            self?.listCast = movieCredits.cast
            DispatchQueue.main.async{ [weak self] in
                self?.castCollection.reloadData()
            }
        }
        //        dispatchGroup.leave()
        //
        //        // 1
        //        dispatchGroup.notify(queue: .main, execute: {[weak self] in
        //
        //            if let movie = self?.movie {
        //                self?.ibdmText.text = "IBDm  \(movie.voteAverage)"
        //                self?.moiveNameText.text = movie.title
        //                self?.overViewText.text = movie.overview
        //                self?.actionText.desc = movie.genres.first?.name ?? "Action"
        //                self?.ageText.desc = movie.adult ? "18+" : "10+"
        //                self?.statusText.desc = movie.status
        //                self?.originalLanguageText.desc = movie.originalLanguage
        //                self?.revenueText.desc = "\(movie.revenue)"
        //                self?.budget.desc = "\(movie.budget)"
        //            }
        //
        //            self?.castCollection.reloadData()
        //            self?.reloadInputViews()
        //
        //        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func setupMenuCollectionView() {
        
        // Popular Movies
        castCollection.delegate = self
        castCollection.dataSource = self
        castCollection.showsHorizontalScrollIndicator = false
        castCollection.isPagingEnabled = true
        
        if let collectionViewFlowLayout = castCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            collectionViewFlowLayout.estimatedItemSize = .zero
            collectionViewFlowLayout.minimumLineSpacing = 15
            collectionViewFlowLayout.minimumInteritemSpacing = 8
            collectionViewFlowLayout.itemSize = CGSize(width: 80, height: 150)
            collectionViewFlowLayout.collectionView?.backgroundColor = .clear
        }
    }
    
    func setupView(){
        containerView.setGradientView(colorTop: UIColor.init(rgb: 0xFF2C5775), colorBottom: UIColor.init(rgb: 0xFF4F4275))
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        boxIndicatorView.layer.cornerRadius = 20
        indicatorView.layer.cornerRadius = 3
        ibdmView.layer.cornerRadius = 15
        ibdmView.layer.backgroundColor = UIColor.init(rgb: 0xFFF5C517).cgColor
        
        movieImage.backgroundColor = UIColor.lightGray
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(pullIndicatorBox))
        boxIndicatorView.isUserInteractionEnabled = true
        boxIndicatorView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func pullIndicatorBox() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(MovieContentViewController.panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRectMake(0, y + translation.y, view.frame.width, view.frame.height)
        recognizer.setTranslation(CGPointZero, in: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height * 0.1
            self?.view.frame = CGRectMake(0, yComponent, frame!.width, frame!.height)
        }
    }
}

extension MovieContentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
}

extension MovieContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = castCollection.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CastCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.castImage.layer.cornerRadius = 15
        
        cell.castImage.load(url: URL(string: baseImageUrl + (listCast[indexPath.row].profilePath ?? ""))!)
        cell.actorName.text = listCast[indexPath.row].originalName
        cell.charactorName.text = listCast[indexPath.row].character ?? ""
        
        return cell
        
    }
}
