//
//  UIViewExtension.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import UIKit

enum ViewFeatures {
    case rounded, shadow, color(UIColor), bordered(UIColor, CGFloat), image(UIImage), topRounded, fullRounded, customRounded(UIRectCorner)
    
}

enum RoundedType {
    case full, onlyLayer
}

extension UIView {

    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
        
    }

    func makeViewWith(features: [ViewFeatures]?) {
        if let features = features as [ViewFeatures]? {
            features.forEach({
                switch $0 {
                case .rounded: self.layer.cornerRadius = 10; self.clipsToBounds = true
                case .shadow: self.setShadow()
                case .color(let color): self.backgroundColor = color
                case .bordered(let color, let borderWidth): self.setCornerRadius(color: color, borderWidth: borderWidth)
                case .image(let image): (self as! UIImageView).image = image
                case .topRounded: self.setTopRounded()
                case .fullRounded: self.setFullRounded()
                case .customRounded(let corners): self.setRounded(at: corners, cornerRad: 10)
                }
            })
        }
    }

}

@objc extension UIView {
    
    @objc func setRounded(at roundingCorners: UIRectCorner, cornerRad: CGFloat) {
        self.layer.mask = {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRad, height:  cornerRad))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            return maskLayer
        }()
    }
    
    @objc func setTopRounded() {
        self.setRounded(at: [.topLeft, .topRight], cornerRad: 30)
        
    }
    
    @objc func setFullRounded() {
        self.setRounded(at: [.topRight, .topLeft, .bottomLeft, .bottomRight], cornerRad: 10)
        
    }
    
    @objc func setShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        
    }
    
    @objc func setCornerRadius(color: UIColor, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        
    }
    
    @objc func addActivityIndicator(bgColor: UIColor?) {
        self.addSubview({
            let childView = UIView()
            childView.backgroundColor = bgColor ?? .red
            childView.frame = self.bounds
            childView.addSubview({
                let activityIndicator = UIActivityIndicatorView(style: .medium)
                activityIndicator.color = .white
                activityIndicator.frame = self.bounds
                activityIndicator.startAnimating()
                return activityIndicator
                
            }())
            return childView
            
        }())
    }
    
    @objc func gradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = frame.size
        gradientLayer.colors = colors.map { $0.cgColor }
        var locations = [CGFloat]()
        for i in 0 ..< colors.count {
            locations.append(CGFloat(i) / CGFloat(colors.count-1))
        }
        gradientLayer.locations = locations as [NSNumber]
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func animateAsNotAllowed() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(translationX: -15, y: 0)
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(translationX: 15, y: 0)
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
                    self.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                })
            })
        })
    }
    
}
