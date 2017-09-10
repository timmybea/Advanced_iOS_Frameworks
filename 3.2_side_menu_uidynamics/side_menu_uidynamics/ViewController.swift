//
//  ViewController.swift
//  side_menu_uidynamics
//
//  Created by Tim Beals on 2017-02-28.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let sideMenu = SideMenu(menuWidth: 160, menuItems: ["Home", "Friends", "Settings", "Trending"], parentViewController: self)
        sideMenu.sideMenuDelegate = self
    }

    //MARK: SideMenuDelegate method
    func didSelectMenuItem(title: String, index: Int) {
        
        print(title)
        
    }
}

