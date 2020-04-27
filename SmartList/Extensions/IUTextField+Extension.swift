//
//  IUTextField+Extension.swift
//  SmartList
//
//  Created by Oleksandr Gribov on 4/27/20.
//  Copyright © 2020 Oleksandr Gribov. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func addBottomLine(_ color: UIColor) {
        let bottomLine = UIView()
        
        bottomLine.backgroundColor = color
        self.addSubview(bottomLine)
        bottomLine.setConstraints(top: nil, paddingTop: 0, bottom: self.bottomAnchor, paddingBottom: 1, right: self.rightAnchor, paddingRight: 0, left: self.leftAnchor, paddingLeft: 0, height: 3, width: 0)
    }
}
