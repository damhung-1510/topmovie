//
//  HomePageView.swift
//  movietop
//
//  Created by Dam Hung on 22/02/2023.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var accountNameText: UILabel!
    
    @IBOutlet weak var popularMoviesCollection: UICollectionView!
    
    @IBOutlet weak var upcomingColletionView: UICollectionView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var searchBoxView: UIView!
    
    @IBOutlet weak var bellImage: UIImageView!
    
    @IBOutlet weak var searchImage: UIImageView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var microImage: UIImageView!
    
    @IBOutlet weak var popularPageControl: UIPageControl!
    
    @IBOutlet weak var upcomingPageControl: UIPageControl!
    
    @IBOutlet weak var genresButton: CustomCategoryView!
    
    @IBOutlet weak var tvSeriesButton: CustomCategoryView!
    
    @IBOutlet weak var movieButton: CustomCategoryView!
    
    @IBOutlet weak var inTheatreButton: CustomCategoryView!
    
    @IBOutlet var superView: UIView!
    
    var myMovies: [MovieRecommend] = []
    
    var upcomingMovies: [MovieRecommend] = []
    
    let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width
    let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieRecommend() { movies in
            self.myMovies = movies
            DispatchQueue.main.async{ [weak self] in
                self?.popularMoviesCollection.reloadData()
                
            }
        }
        
        getUpcomingMovies() { movies in
            self.upcomingMovies = movies
            DispatchQueue.main.async{ [weak self] in
                self?.upcomingColletionView.reloadData()
            }
        }
        /// press category view
        movieButton.onPress = { desc in
            print("movieButton \(desc)")
        }
        
        genresButton.onPress = { desc in
            print("genresButton \(desc)")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMenuCollectionView()
        setupSearchBarView()
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        superView.setGradientView(colorTop: UIColor.init(rgb: 0xFF2C5775), colorBottom: UIColor.init(rgb: 0xFF4F4275))
        searchBoxView.setGradientView(colorTop: UIColor.init(rgb: 0xFF425A84), colorBottom: UIColor.init(rgb: 0xFF556F94))
    }
    
    func setupSearchBarView(){
        accountNameText.text = "Hi, Hungdq"
        accountNameText.highlight(text: "Hungdq", font: UIFont.systemFont(ofSize: 18, weight: .heavy), color: .white)
        
        bellImage.image = UIImage(systemName: "bell")!
        bellImage.tintColor = UIColor.white
        
        searchImage.image = UIImage(systemName: "magnifyingglass")!
        searchImage.tintColor = UIColor.white
        
        microImage.image = UIImage(systemName: "mic")!
        microImage.tintColor = UIColor.white
        
        searchBoxView.layer.cornerRadius = 15
        searchBoxView.layer.masksToBounds = true
        searchBoxView.layer.borderColor = UIColor.lightGray.cgColor
        searchBoxView.layer.borderWidth = 1
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
    }
    
    func customButton(imageName: String, title: String, view: UIView){
        view.setGradientView(colorTop: UIColor.init(rgb: 0xFF425A84), colorBottom: UIColor.init(rgb: 0xFF556F94))
        
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        
    }
    
    private func setupMenuCollectionView() {
        
        // Popular Movies
        popularMoviesCollection.delegate = self
        popularMoviesCollection.dataSource = self
        popularMoviesCollection.showsHorizontalScrollIndicator = false
        popularMoviesCollection.showsVerticalScrollIndicator = false
        popularMoviesCollection.translatesAutoresizingMaskIntoConstraints = false
        popularMoviesCollection.decelerationRate = .fast
        popularMoviesCollection.backgroundColor = .clear
        
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: 120)
        layout.minimumLineSpacing = cellSpacing
        
        
        popularMoviesCollection.collectionViewLayout = layout
        // Popular Movies
        upcomingColletionView.delegate = self
        upcomingColletionView.dataSource = self
        upcomingColletionView.showsHorizontalScrollIndicator = false
        upcomingColletionView.showsVerticalScrollIndicator = false
        upcomingColletionView.isPagingEnabled = true
        upcomingColletionView.showsVerticalScrollIndicator = false
        
        if let collectionViewFlowLayout = upcomingColletionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.estimatedItemSize = .zero
            collectionViewFlowLayout.minimumLineSpacing = 15
            collectionViewFlowLayout.minimumInteritemSpacing = 8
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            collectionViewFlowLayout.itemSize = CGSize(width: 120, height: 200)
            collectionViewFlowLayout.collectionView?.backgroundColor = .clear
        }
    }
    
}

extension HomePageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie: MovieRecommend
        print(indexPath.row)
        if collectionView == popularMoviesCollection {
            movie = myMovies[indexPath.row]
        } else {
            movie = upcomingMovies[indexPath.row]
        }
        tapMovie(movie: movie)
    }
    
    func tapMovie(movie: MovieRecommend) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        vc?.movieId = movie.id ?? 0
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
        
        if collectionView == popularMoviesCollection {
            popularPageControl.currentPage = indexPath.row
        } else {
            upcomingPageControl.currentPage = indexPath.row
        }
    }
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularMoviesCollection{
            popularPageControl.numberOfPages = myMovies.count
            popularPageControl.isHidden = !(myMovies.count > 1)
            return myMovies.count
        }
        upcomingPageControl.numberOfPages = upcomingMovies.count
        upcomingPageControl.isHidden = !(upcomingMovies.count > 1)
        return upcomingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == popularMoviesCollection {
            let cell = popularMoviesCollection.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
            cell.backgroundColor = UIColor.clear
            cell.layer.cornerRadius = 25
            cell.movieTitle.text = myMovies[indexPath.row].name ?? ""
            
            cell.movieImage.load(url: URL(string: baseImageUrl + (self.myMovies[indexPath.row].posterPath ?? ""))!)
            return cell
        } else{
            let cell = upcomingColletionView.dequeueReusableCell(withReuseIdentifier: "upcomingMovieCell", for: indexPath) as! UpcomingMovieViewCell
            cell.backgroundColor = UIColor.clear
            cell.layer.cornerRadius = 25
            
            cell.upcomingImage.load(url: URL(string: baseImageUrl + (self.upcomingMovies[indexPath.row].posterPath ?? ""))!)
            
            return cell
        }
    }
}

