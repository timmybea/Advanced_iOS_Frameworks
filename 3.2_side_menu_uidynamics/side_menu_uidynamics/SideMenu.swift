//
//  SideMenu.swift
//  side_menu_uidynamics
//
//  Created by Tim Beals on 2017-02-28.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

protocol SideMenuDelegate {
    func didSelectMenuItem(title: String, index: Int)
}


class SideMenu: UIView, UITableViewDelegate, UITableViewDataSource {

    var backgroundView: UIView!
    var menuTableView: UITableView!
    var width: CGFloat = 0
    var menuItemTitles = [String]()
    var dynamicAnimator: UIDynamicAnimator!
    var parentViewController: ViewController!
    var sideMenuDelegate: SideMenuDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(menuWidth: CGFloat, menuItems: [String], parentViewController: ViewController) {
        super.init(frame: CGRect(x: -menuWidth, y: 20, width: menuWidth, height: parentViewController.view.frame.height - 20))
        self.width = menuWidth
        self.menuItemTitles = menuItems
        self.backgroundColor = UIColor.purple
        self.parentViewController = parentViewController
        self.parentViewController.view.addSubview(self)
        
        setupMenuView()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: parentViewController.view)
        
        setupGestureRecognizers()
        
    }
    
    func setupMenuView() {
        backgroundView = UIView(frame: parentViewController.view.frame)
        backgroundView.backgroundColor = UIColor.lightGray
        backgroundView.alpha = 0
        parentViewController.view.insertSubview(backgroundView, belowSubview: self)
        
        menuTableView = UITableView(frame: self.bounds, style: .plain)
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        menuTableView.separatorStyle = .none
        menuTableView.backgroundColor = UIColor.clear
        menuTableView.isScrollEnabled = false
        menuTableView.alpha = 1
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.reloadData()
        
        self.addSubview(menuTableView)
    }
    
    //MARK: swipe gesture methods

    
    func setupGestureRecognizers() {
        
        let showMenuSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(recognizer:)))
        showMenuSwipeGesture.direction = .right
        parentViewController.view.addGestureRecognizer(showMenuSwipeGesture)
        
        let hideMenuSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(recognizer:)))
        hideMenuSwipeGesture.direction = .left
        parentViewController.view.addGestureRecognizer(hideMenuSwipeGesture)
    }
    
    func handleSwipeGesture(recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == .right {
            toggleMenu(open: true)
        } else {
            toggleMenu(open: false)
        }
    }

    func toggleMenu(open: Bool) {
    
        //You change the behaviors based on opening or closing, so you need to start with an empty animator
        dynamicAnimator.removeAllBehaviors()
        
        let gravityX: CGFloat = open ? 2 : -1
        let pushMagnitude: CGFloat = open ? 2 : -20
        let boundaryX: CGFloat = open ? width : -width - 5
        
        let gravity = UIGravityBehavior(items: [self])
        gravity.gravityDirection = CGVector(dx: gravityX, dy: 0)
        dynamicAnimator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [self])
        collision.addBoundary(withIdentifier: 1 as NSCopying, from: CGPoint(x: boundaryX, y: 20), to: CGPoint(x: boundaryX, y: parentViewController.view.bounds.height))
        dynamicAnimator.addBehavior(collision)
        
        
        let push = UIPushBehavior(items: [self], mode: .instantaneous)
        push.magnitude = pushMagnitude
        dynamicAnimator.addBehavior(push)
        
        let menuElasticity = UIDynamicItemBehavior(items: [self])
        menuElasticity.elasticity = 0.4
        dynamicAnimator.addBehavior(menuElasticity)
        
        UIView.animate(withDuration: 0.2) { 
            self.backgroundView.alpha = open ? 0.5 : 0
        }
        
    }
    
    
    //MARK: table view methods
    let cellID = "cellID"
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemTitles.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }

        cell?.textLabel?.text = menuItemTitles[indexPath.row]
        cell?.textLabel?.textColor = UIColor.lightGray
        cell?.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 17)
        cell?.textLabel?.textAlignment = .left
        cell?.backgroundColor = UIColor.clear
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //this will deselect the row after it has been selected
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        if let delegate = sideMenuDelegate {
            delegate.didSelectMenuItem(title: menuItemTitles[indexPath.row], index: indexPath.row)
        }
    }
}
