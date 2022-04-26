//
//  PreviewView.swift
//  Maastricht guide
//
//  Created by  Mr.Ki on 26.04.2022.
//

import UIKit

class PreviewView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Share")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let labelType: UILabel = {
        let label = UILabel()
        label.text = "📸"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        setupPreviewView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String, image: UIImage, type: String) {
        labelTitle.text = title
        imageView.image = image
        labelType.text = type
    }
 
    
    func setupPreviewView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
        containerView.leftAnchor.constraint(equalTo: leftAnchor),
        containerView.topAnchor.constraint(equalTo: topAnchor),
        containerView.rightAnchor.constraint(equalTo: rightAnchor),
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        containerView.addSubview(labelTitle)
        NSLayoutConstraint.activate([
        labelTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
        labelTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
        labelTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
        labelTitle.heightAnchor.constraint(equalToConstant: 35)
        ])
        addSubview(imageView)
        NSLayoutConstraint.activate([
        imageView.leftAnchor.constraint(equalTo: leftAnchor),
        imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor),
        imageView.rightAnchor.constraint(equalTo: rightAnchor),
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        addSubview(labelType)
        NSLayoutConstraint.activate([
        labelType.centerXAnchor.constraint(equalTo: centerXAnchor),
        labelType.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        labelType.widthAnchor.constraint(equalToConstant: 90),
        labelType.heightAnchor.constraint(equalToConstant: 40)
        ])
       }
       
      
       
    
}
