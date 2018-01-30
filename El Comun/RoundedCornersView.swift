//
//  RoundedCornersView.swift
//  El Comun
//
//  Created by Francisco Ochoa on 18/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}
