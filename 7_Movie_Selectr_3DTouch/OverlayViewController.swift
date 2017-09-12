//
//  OverlayViewController.swift
//  Movie_Selectr
//
//  Created by Tim Beals on 2017-09-10.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {
    
    var movie: Movie? {
        didSet {
            configureForMovie(movie: movie!)
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.init(white: 1.0, alpha: 0.8)
        textView.textAlignment = .justified
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        setupSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.width - 40, height: 200)
        self.view.layer.cornerRadius = 8.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupSubviews() {
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8).isActive = true
        textView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
    }
    
    private func configureForMovie(movie: Movie) {
        titleLabel.text = movie.title
        textView.text = movie.description
    }
    
}
