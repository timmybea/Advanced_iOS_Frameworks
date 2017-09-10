//
//  PieView.swift
//  live_render
//
//  Created by Tim Beals on 2017-02-27.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

@IBDesignable
class PieView: UIView {
    
    
    //MARK: variables
    var backgroundLayer: CAShapeLayer!
    @IBInspectable var backgroundLayerColor: UIColor = UIColor.darkGray {
        didSet {
            updateLayerProperties()
        }
    }
    
    var backgroundImageLayer: CALayer!
    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            updateLayerProperties()
        }
    }
    
    var ringLayer: CAShapeLayer!
    @IBInspectable var ringThickness: CGFloat = 2
    @IBInspectable var ringColor: UIColor = UIColor.blue
    @IBInspectable var ringProgress: CGFloat = 0.75 {
        didSet {
            updateLayerProperties()
        }
    }

    var percentageLayer: CATextLayer!
    @IBInspectable var showPercentage: Bool = true {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable var percentagePosition: CGFloat = 100 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable var percentageColor: UIColor = UIColor.white {
        didSet {
            updateLayerProperties()
        }
    }

    var lineWidth: CGFloat = 1
    
    
    //MARK: functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createChart()
    }

    func createChart() {
        layoutBackgroundLayer()
        layoutBackgroundImageLayer()
        createPie()
        updateLayerProperties()
    }
    
    func layoutBackgroundLayer() {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            layer.addSublayer(backgroundLayer)
            
            backgroundLayer.frame = layer.bounds
            
            let rectangle = bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
            let path = UIBezierPath(ovalIn: rectangle)
            
            backgroundLayer.path = path.cgPath
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
            backgroundLayer.lineWidth = lineWidth
        }
    }
    
    func layoutBackgroundImageLayer() {
        if backgroundImageLayer == nil {
            
            //make image mask to trim the photo
            let imageMask = CAShapeLayer()
            let inset = lineWidth + 3
            let rectangle = self.bounds.insetBy(dx: inset, dy: inset)
            let maskPath = UIBezierPath(ovalIn: rectangle)
            
            imageMask.path = maskPath.cgPath
            imageMask.fillColor = UIColor.black.cgColor
            imageMask.frame = self.bounds
            
            backgroundImageLayer = CAShapeLayer()
            backgroundImageLayer.mask = imageMask
            backgroundImageLayer.frame = self.bounds
            
            //this is like content mode in UIImageView
            backgroundImageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(backgroundImageLayer)
        }
    }

    
    func createPie() {
        if ringProgress == 0 {
            if ringLayer != nil {
                ringLayer.strokeEnd = 0
            }
        }
        
        if ringLayer == nil {
            ringLayer = CAShapeLayer()
            layer.addSublayer(ringLayer)
            let inset = ringThickness / 2
            let rectangle = bounds.insetBy(dx: inset, dy: inset)
            let path = UIBezierPath(ovalIn: rectangle)
            ringLayer.path = path.cgPath
            
            ringLayer.transform = CATransform3DMakeRotation(CGFloat(-(M_PI_2)), 0, 0, 1)
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.fillColor = nil
            ringLayer.lineWidth = ringThickness
            ringLayer.strokeStart = 0
            
        }
        
        ringLayer.strokeEnd = ringProgress / 100
        ringLayer.frame = layer.bounds
        
        if percentageLayer == nil {
            percentageLayer = CATextLayer()
            layer.addSublayer(percentageLayer)
            percentageLayer.font = UIFont(name: "HiraginoSans-W6", size: 20)
            percentageLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: percentageLayer.fontSize + 10)
            percentageLayer.position = CGPoint(x: bounds.midX, y:percentagePosition)
            percentageLayer.string = "\(Int(ringProgress))%"
            percentageLayer.alignmentMode = kCAAlignmentCenter
            percentageLayer.foregroundColor = percentageColor.cgColor
            percentageLayer.contentsScale = UIScreen.main.scale
        }
    }
    
    func updateLayerProperties() {
        
        if backgroundImageLayer != nil {
            if let image = backgroundImage {
                backgroundImageLayer.contents = image.cgImage
            }
        }
        
        if backgroundLayer != nil {
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
            
        }
        
        if ringLayer != nil {
            ringLayer.strokeEnd = ringProgress / 100
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.lineWidth = ringThickness
            
        }
        
        if percentageLayer != nil {
            if showPercentage {
                percentageLayer.opacity = 1
                percentageLayer.string = "\(Int(ringProgress))%"
                percentageLayer.position = CGPoint(x: bounds.midX, y:percentagePosition)
                percentageLayer.foregroundColor = percentageColor.cgColor
            } else {
                percentageLayer.opacity = 0
            }
        }
    }
}


//@IBDesignable
//class CustomIBview: UIView {
//
//
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//            layer.masksToBounds = cornerRadius > 0
//        }
//    }
//    @IBInspectable var borderWidth: CGFloat = 0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//    @IBInspectable var borderColor: UIColor? {
//        didSet {
//            layer.borderColor = borderColor?.cgColor
//        }
//    }
//}



//@IBDesignable class EllipseView: UIView {
//    @IBInspectable var strokeWidth: CGFloat = 0
//    @IBInspectable var fillColor: UIColor = UIColor.black
//    @IBInspectable var strokeColor: UIColor = UIColor.clear
//
//    override func draw(_ rect: CGRect) {
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        let rectangle = bounds.insetBy(dx: strokeWidth / 2, dy: strokeWidth / 2)
//
//        context.setFillColor(fillColor.cgColor)
//        context.setStrokeColor(strokeColor.cgColor)
//        context.setLineWidth(strokeWidth)
//
//        context.addEllipse(in: rectangle)
//        context.drawPath(using: .fillStroke)
//    }
//}

