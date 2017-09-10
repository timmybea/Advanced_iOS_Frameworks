//
//  ViewController.swift
//  starting_dynamics
//
//  Created by Tim Beals on 2017-02-27.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    var dynamicAnimator: UIDynamicAnimator!

    var ball: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        ball.frame = CGRect(x: (view.frame.width / 2) - 25, y: 30, width: 50, height: 50)
        ball.layer.cornerRadius = ball.bounds.width / 2
        
        groundView.frame = CGRect(x: 16, y: view.frame.height * 0.9, width: view.frame.width - 32, height: 24)
        
        view.addSubview(ball)
        view.addSubview(groundView)
        
        addAnimationBehavior()
    }
    
    
    func addAnimationBehavior() {
        
        let gravity = UIGravityBehavior(items: [ball])
        dynamicAnimator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [ball])
        collision.addBoundary(withIdentifier: 1 as NSCopying, from: groundView.frame.origin, to: CGPoint(x: groundView.frame.origin.x + groundView.frame.width, y: groundView.frame.origin.y))
        dynamicAnimator.addBehavior(collision)
        
        collision.collisionDelegate = self
        
//        let ballBehavior = UIDynamicItemBehavior(items: [ball])
//        ballBehavior.elasticity = 0.75
//        dynamicAnimator.addBehavior(ballBehavior)
    
        
    }
    
    //MARK: delegate method for collisions
    
    var index = 0
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        let colorArray = [UIColor.cyan, UIColor.purple, UIColor.green, UIColor.yellow, UIColor.red]
        
        if let number = identifier as! Int? { //if NSNumber(integerLiteral: 1).isEqual(identifier) {
            
            if number == 1 {
                ball.backgroundColor = colorArray[index]
                
                if index < 4 {
                    index += 1
                } else {
                    index = 0
                }
            }
        }
    }
    
}

