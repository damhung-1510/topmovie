//
//  MovieDetailViewController.swift
//  movietop
//
//  Created by Dam Hung on 23/02/2023.
//

import UIKit
//import FloatingPanel

class MovieDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    

    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        let mainStorboard = UIStoryboard(name: "Main", bundle: nil)
        let bottomSheetVC = mainStorboard.instantiateViewController(withIdentifier: "MovieContentViewController")

        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)

        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRectMake(0, self.view.frame.maxY, width, height)
    }

}
