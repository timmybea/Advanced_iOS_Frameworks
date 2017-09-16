//
//  Shakeable.swift
//  Real_World_POP
//
//  Created by Tim Beals on 2017-09-15.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

//Note that the protocol is empty because we can only implement the function in an extension.

protocol Shakeable { }

extension Shakeable where Self : UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
    
}
