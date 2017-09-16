//
//  ViewController.swift
//  Real_World_POP
//
//  Created by Tim Beals on 2017-09-15.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//The goal: We want to make some UI items 'shakeable'. That is to say, we want to choose which UI items have the animation, and we want to avoid repeating the same animation code.




class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var shakeTextField: ShakeTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()


        shakeTextField.delegate = self
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        shakeTextField.shake()
        return true
    }

}

