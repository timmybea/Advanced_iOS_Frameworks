//
//  ViewController.swift
//  PresentationController
//
//  Created by Tim Beals on 2017-09-10.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        view.backgroundColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTouched(sender:)))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func addButtonTouched(sender: UIBarButtonItem) {
        print("Add Button touched")
        
        let destination = SecondViewController()
        destination.modalPresentationStyle = .popover
        
        let destinationPopOver = destination.popoverPresentationController!
        
        let sourceButton = sender as! UIBarButtonItem
        
        destinationPopOver.barButtonItem = sourceButton
        destinationPopOver.permittedArrowDirections = .any
        
        self.present(destination, animated: true, completion: nil)
        
        

    }


}

