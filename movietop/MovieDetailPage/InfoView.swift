//
//  CustomButtonView.swift
//  movietop
//
//  Created by Dam Hung on 23/02/2023.
//

import UIKit

@IBDesignable
class InfoView: UIView {

    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .left
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 12,  weight: .bold)
        title.numberOfLines = 0
        return title
        
    }()
    
    let content: UILabel = {
        let content = UILabel()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.textAlignment = .left
        content.textColor = .white
        content.font = UIFont.systemFont(ofSize: 12)
        content.numberOfLines = 0
        return content
        
    }()
    
    @IBInspectable
    var titleText: String = "" {
        didSet{
            self.title.text = titleText
        }
    }
    
    @IBInspectable
    var desc: String = "" {
        didSet{
            self.content.text = desc
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    func setupView(){
        self.layer.masksToBounds = true
        self.backgroundColor = .clear
        
        self.addSubview(title)
        self.addSubview(content)
        
        // AUTO LAYOUT
        
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        content.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        content.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true

    }
    
}
