//
//  UIApplicationExtension.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import UIKit

extension UIColor {
    class var masterColor: UIColor {
        return UIColor(red: 245/255, green: 0/255, blue: 152/255, alpha: 1)
        
    }
    class var labelColor: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .lightGray
    }
    }
    class var tertiarySystemBackgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return .tertiarySystemBackground
        } else {
            return .white
        }
    }
    class var secondaryLabelColor: UIColor {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .lightGray
        }
    }
    class var systemBGColor: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
}
