//
//  CustomPinView.swift
//  Maastricht guide
//
//  Created by  Mr.Ki on 26.04.2022.
//

import UIKit

class CustomPinView: UIView {
    
    var image: UIImage!
    var borderColor: UIColor!
    
    init(frame: CGRect, image: UIImage, borderColor: UIColor, tag: Int) {
        super.init(frame: frame)
        self.image = image
        self.borderColor = borderColor
        self.tag = tag
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.layer.cornerRadius = 25
        imageView.layer.borderColor = borderColor?.cgColor
        imageView.layer.borderWidth = 4
        imageView.clipsToBounds = true
        
        let label = UILabel(frame: CGRect(x: 0, y: 45, width: 50, height: 10))
        label.text = "⭐️"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = borderColor
        label.textAlignment = .center
        
        self.addSubview(imageView)
        self.addSubview(label)
       
    }
    
}
