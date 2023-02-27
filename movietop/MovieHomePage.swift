//
//  MovieHomePage.swift
//  movietop
//
//  Created by Dam Hung on 21/02/2023.
//

import UIKit

class MovieHomePage: UIViewController {

    let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width
    let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    
    let colors: [UIColor] = [.red, .green, .blue, .purple, .orange, .black, .cyan]
    let cellId = "cell id"
    

    @IBOutlet weak var collectionDemoView: UICollectionView!
    // MARK: - UI Components
    
    lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        design()
//        registerCollectionViewCells()
//        applyConstraints()
    }
    
    // MARK: - Setup
    
    private func design() {
        view.backgroundColor = .white
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.minimumLineSpacing = cellSpacing
        
        collectionDemoView.translatesAutoresizingMaskIntoConstraints = false
        collectionDemoView.showsHorizontalScrollIndicator = false
        collectionDemoView.backgroundColor = .white
        collectionDemoView.decelerationRate = .fast
        collectionDemoView.dataSource = self
        collectionDemoView.collectionViewLayout = layout
    }
    
//    private func registerCollectionViewCells() {
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
//    }
    
    private func applyConstraints() {
        view.addSubview(collectionView)
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
}

// MARK: - CollectionView Data Source
extension MovieHomePage: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
        let color = colors[indexPath.item]
        cell.backgroundColor = color
        return cell
    }
}
