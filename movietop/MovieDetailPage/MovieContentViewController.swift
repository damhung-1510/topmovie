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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupMenuCollectionView()
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
            collectionViewFlowLayout.itemSize = CGSize(width: 80, height: 165)
            collectionViewFlowLayout.collectionView?.backgroundColor = .clear
        }
    }
    
    func setupView(){
        containerView.setGradientView(colorTop: UIColor.init(rgb: 0xFF2C5775), colorBottom: UIColor.init(rgb: 0xFF4F4275))
        containerView.layer.cornerRadius = 20
        boxIndicatorView.layer.cornerRadius = 20
        indicatorView.layer.cornerRadius = 3
        ibdmView.layer.cornerRadius = 15
        ibdmView.layer.backgroundColor = UIColor.init(rgb: 0xFFF5C517).cgColor
        
        ibdmText.text = "IBDm  "
        
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
            let yComponent = UIScreen.main.bounds.height * 0.2
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
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = castCollection.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CastCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.layer.cornerRadius = 20
        cell.layer.backgroundColor = UIColor.red.cgColor
        
        return cell
        
    }
}
