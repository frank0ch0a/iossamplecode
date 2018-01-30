//
//  LeftAlignedIconButton.swift
//  El Comun
//
//  Created by Francisco Ochoa on 8/06/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit
@IBDesignable
class LeftAlignedIconButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
    }
}
