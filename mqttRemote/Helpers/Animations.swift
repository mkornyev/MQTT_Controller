//
//  Animations.swift
//  mqttRemote
//
//  Created by Max Kornyev on 12/5/20.
//  Copyright © 2020 msk. All rights reserved.
//

import Foundation
import UIKit

protocol ElementAnimations {
    static func bounceImage(_ imageView:UIImageView)
}

extension ElementAnimations {
    static func bounceImage(_ imageView:UIImageView) {
        
        imageView.center.y = imageView.center.y - 100
        imageView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            imageView.alpha = 1
            imageView.center.y = imageView.center.y + 100
        }, completion: nil)
        
    }
}
