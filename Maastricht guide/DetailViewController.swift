//
//  DetailViewController.swift
//  Maastricht guide
//
//  Created by  Mr.Ki on 26.04.2022.
//


import UIKit

class DetailViewController: UIViewController {
    
    var passedData = (title: "Name", image: UIImage(named: "Share"), type: "⭐️")
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Challenge")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let labelType: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor(white: 0.5, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labeldescription: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupDetailView()
    }
    
    func setupDetailView() {
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: view.topAnchor),
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
        scrollView.contentSize.height = 800
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
        imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
        imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
        imageView.heightAnchor.constraint(equalToConstant: 200),
        
        ])
        imageView.image = passedData.image
        containerView.addSubview(labelTitle)
        NSLayoutConstraint.activate([
        labelTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
        labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor),
        labelTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
        labelTitle.heightAnchor.constraint(equalToConstant: 50),
       
        ])
        labelTitle.text = passedData.title
        containerView.addSubview(labelType)
        NSLayoutConstraint.activate([
        labelType.leftAnchor.constraint(equalTo: labelTitle.leftAnchor),
        labelType.topAnchor.constraint(equalTo: labelTitle.bottomAnchor),
        labelType.rightAnchor.constraint(equalTo: labelTitle.rightAnchor),
        labelType.heightAnchor.constraint(equalToConstant: 40),
       
        ])
        labelType.text = passedData.type
        containerView.addSubview(labeldescription)
        NSLayoutConstraint.activate([
        labeldescription.leftAnchor.constraint(equalTo: labelTitle.leftAnchor),
        labeldescription.topAnchor.constraint(equalTo: labelType.bottomAnchor, constant: 10),
        labeldescription.rightAnchor.constraint(equalTo: labelTitle.rightAnchor),
        ])
        labeldescription.text = "\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\""
        labeldescription.sizeToFit()
    }
    
    
}
