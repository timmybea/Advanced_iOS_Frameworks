//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Tim Beals on 2017-09-13.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import NotificationCenter
import BridgingHeader

class TodayViewController: UIViewController, NCWidgetProviding {
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none
        tableview.allowsSelection = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableview
    }()
    
    var compactMode = true
    
    var nowPlaying = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    
    private func setupSubviews() {
        
        self.view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    func loadData() {
        
        Movie.nowPlaying { (success, movies) in
            
            self.nowPlaying = movies!
            
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Swift.Void) {

        loadData()
        completionHandler(.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .compact {
            self.compactMode = true
            self.preferredContentSize = CGSize(width: 0, height: 120)
        } else {
            self.compactMode = false
            self.preferredContentSize = CGSize(width: 0, height: 220)
        }
        tableView.reloadData()
    }
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if compactMode {
            return 2
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if nowPlaying.count > 0 {
            let movie = nowPlaying[indexPath.row]
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.text = movie.title
        
            Movie.getImageData(forCell: cell, withMovieObject: movie)
        }
        
        return cell
    }
    
    
}
