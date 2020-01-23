//
//  UniverseViewUtilities.swift
//  UniverseImagery
//
//  Created by Bharath on 23/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func enable(_ shouldEnable: Bool, withAlpha value: CGFloat = 1.0, animate: Bool = false) {
        
        self.isUserInteractionEnabled = shouldEnable
        
        if animate == true {
            UIView.animate(withDuration: 0.5, animations: { [unowned self] () -> Void in
                self.alpha = value
            })
        }
        else {
            alpha = value
        }
    }
}
