//
//  TestViewController.swift
//  Movie_Selectr
//
//  Created by Tim Beals on 2017-09-12.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var movie: Movie? {
        didSet {
            configureForMovie()
        }
    }
    
    let posterImage: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        
        view.addSubview(posterImage)
        posterImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        posterImage.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        posterImage.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func configureForMovie() {
        if let imageData = Movie.getImageData(for: self.movie!) {
            self.posterImage.image = UIImage(data: imageData)
        }
    }
    
}
