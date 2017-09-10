//
//  SecondViewController.swift
//  PresentationController
//
//  Created by Tim Beals on 2017-09-10.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.backgroundColor = UIColor.cyan
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(backButtonTouched(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        view.backgroundColor = UIColor.darkGray
        
        setupSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc private func backButtonTouched(sender: UIButton) {
        print("Back button touched")
        
        self.dismiss(animated: true, completion: nil)
    }

    
    private func setupSubviews() {
        
        view.addSubview(backButton)
        backButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
    }
    
}
