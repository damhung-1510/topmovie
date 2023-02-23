//
//  CustomCategoryView.swift
//  movietop
//
//  Created by Dam Hung on 22/02/2023.
//

import UIKit

@IBDesignable
class CustomCategoryView: UIView {
    
    let iconCategory: UIImageView = {
        let iconCategory = UIImageView()
        iconCategory.translatesAutoresizingMaskIntoConstraints = false
        iconCategory.contentMode = .scaleAspectFit
        return iconCategory
    } ()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 11)
        title.numberOfLines = 0
        return title
        
    }()
    
    @IBInspectable
    var image: UIImage = UIImage(systemName: "person")! {
        didSet{
            self.iconCategory.image = image
        }
    }
    @IBInspectable
    var desc: String = "" {
        didSet{
            self.title.text = desc
        }
    }
    
    var onPress: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    func setupView(){
        self.setGradientView(colorTop: UIColor.init(rgb: 0xFF425A84), colorBottom: UIColor.init(rgb: 0xFF556F94))
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .clear
        
        self.addSubview(iconCategory)
        self.addSubview(title)
        
        // AUTO LAYOUT
        
        iconCategory.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconCategory.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconCategory.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        iconCategory.heightAnchor.constraint(equalTo: iconCategory.widthAnchor, multiplier: 1).isActive = true
        
        title.centerXAnchor.constraint(equalTo: iconCategory.centerXAnchor).isActive = true
        title.topAnchor.constraint(equalTo: iconCategory.bottomAnchor, constant: 8).isActive = true
        title.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapImage() {
         onPress?(desc)
    }
}
