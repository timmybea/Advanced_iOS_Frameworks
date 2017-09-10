//
//  ViewController.swift
//  live_render
//
//  Created by Tim Beals on 2017-02-27.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var previousLocation = CGPoint(x: 0, y: 0)
    var previousValue = 50
    var changingValue = 0
    
    let touchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let pieView: PieView = {
        let view = PieView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        view.backgroundImage = UIImage(named: "abstract")
        view.backgroundLayerColor = ColorManager.backgroundGreen()
        view.ringColor = ColorManager.ringGold()
        view.ringThickness = 6
        view.percentagePosition = 120
        view.ringProgress = 50
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupViews()
        setupPanGesture()
    }

    func setupViews() {
        
        view.addSubview(pieView)
        view.addSubview(touchView)
        
        pieView.center = view.center
        touchView.frame = view.bounds
    }
    
    func setupPanGesture() {
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(panRecognizer:)))
        touchView.addGestureRecognizer(gesture)
        
    }

    func handlePan(panRecognizer: UIPanGestureRecognizer) {
     
        let currentLocation = panRecognizer.location(in: touchView)
        
        if panRecognizer.state == .began {
            
            previousLocation = currentLocation
            
        } else if panRecognizer.state == .changed {
            
            let offset = Int((previousLocation.y - currentLocation.y) / 6)
            
            changingValue = previousValue + offset
            
            if changingValue > 100 {
                changingValue = 100
            } else if changingValue < 0 {
                changingValue = 0
            }

            pieView.ringProgress = CGFloat(changingValue)
            
        } else if panRecognizer.state == .ended {
            previousValue = changingValue
            pieView.ringProgress = CGFloat(previousValue)
        }
    }
}

