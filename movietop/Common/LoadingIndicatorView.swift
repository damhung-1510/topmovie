//
//  LoadingIndicatorView.swift
//  movietop
//
//  Created by Dam Hung on 24/02/2023.
//

import UIKit

class LoadingIndicatorView: UIView {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    func showActivityIndicator(superView: UIView) {
        DispatchQueue.main.async{ [weak self] in
            self?.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self?.center = superView.center
            self?.backgroundColor = UIColor.init(rgb: 0xFF444444)
            self?.alpha = 0.7
            self?.clipsToBounds = true
            self?.layer.cornerRadius = 10

            self?.spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            self?.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self?.spinner.center = CGPoint(x: self?.bounds.size.width ?? 0 / 2, y: self?.bounds.size.height ?? 0 / 2)

            if let spinner = self?.spinner {
                self?.addSubview(spinner)
                if let view = self {
                    superView.addSubview(view)
                }
                spinner.startAnimating()
            }
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async{ [weak self] in
            self?.spinner.stopAnimating()
            self?.removeFromSuperview()
        }
    }

}
