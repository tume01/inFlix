//
//  GradientView.swift
//  Influenster
//
//  Created by Gustavo Villar on 23/8/16.
//  Copyright © 2016 Tekton Labs. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    // MARK: Properties
    
    enum Orientation: Int {
        case horizontal = 0, vertical = 1
    }
    
    var orientation = Orientation.horizontal {
        didSet {
            updateGradientLayer()
        }
    }
    
    /**
     Use this property to set the orientation from a Storyboard.
     Otherwise, use the `orientation` property
     */
    @IBInspectable var orientationRawValue: Int {
        get {
            return orientation.rawValue
        }
        set {
            if let newGradientOrientation = Orientation(rawValue: newValue) {
                orientation = newGradientOrientation
            }
        }
    }
    
    @IBInspectable var initialColor: UIColor = UIColor.blue {
        didSet {
            updateGradientLayer()
        }
    }
    
    @IBInspectable var finalColor: UIColor = UIColor.green {
        didSet {
            updateGradientLayer()
        }
    }
    
    @IBInspectable var startPoint: Double = 0.5 {
        didSet {
            updateGradientLayer()
        }
    }
    
    @IBInspectable var endPoint: Double = 0.5 {
        didSet {
            updateGradientLayer()
        }
    }
    
    // MARK: Initializers
    
    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateGradientLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateGradientLayer()
    }
    
    // MARK: Setup
    
    fileprivate func updateGradientLayer() {
        gradientLayer.colors = [initialColor.cgColor, finalColor.cgColor]
        
        switch orientation {
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: startPoint, y: 0)
            gradientLayer.endPoint = CGPoint(x: endPoint, y: 1)
            
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: startPoint)
            gradientLayer.endPoint = CGPoint(x: 1, y: endPoint)
        }
        
    }
    
}
