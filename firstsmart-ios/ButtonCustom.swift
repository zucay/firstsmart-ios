//
//  ButtonCustom.swift
//  firstsmart-ios
//
//  Created by zuka on 2015/09/27.
//  Copyright © 2015年 zuka. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ButtonCustom: UIButton {
    
    @IBInspectable var textColor: UIColor?
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
}