//
//  ViewController.swift
//  Movie_Selectr
//
//  Created by Tim Beals on 2017-03-07.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 6
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        view.contentInset.top = 20
        view.contentInset.left = 20
        view.contentInset.right = 20
        view.isScrollEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(MovieCellCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        return view
    }()
    
    var movieData = [Movie]()
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Now Playing"
        
        view.backgroundColor = UIColor.cyan
        setupViews()
        
        getMovieData()

    }
    
    func getMovieData() {
        Movie.nowPlaying { (success, movies) in
            if success {

                self.movieData = movies!

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func setupViews() {
        
        
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    //MARK: tableView delegate methods
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movieData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
//        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
//        
//        let movie = movieData[indexPath.row]
//        cell.textLabel?.text = movie.title
//        cell.detailTextLabel?.text = movie.description
//        
//        Movie.getImageData(forCell: cell, withMovieObject: movie)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MovieCellCollectionViewCell
        
        let movie = movieData[indexPath.row]
        
        Movie.getImageData(forCell: cell!, withMovieObject: movie)
        
        cell?.configureWith(movie: movie)
        
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
}

