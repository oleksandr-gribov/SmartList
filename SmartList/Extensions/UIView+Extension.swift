//
//  UIView+Extension.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 4/25/20.
//  Copyright © 2020 Oleksandr Gribov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setConstraints(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?,paddingBottom: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat,  height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}
