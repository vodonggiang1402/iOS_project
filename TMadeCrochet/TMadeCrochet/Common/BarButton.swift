//
//  BarButton.swift
//  Probit
//
//  Created by Vo Dong Giang on 17/11/2023.
//

import Foundation
import UIKit

class BarButton: UIButton {
    var addedTouchArea = CGFloat(0)

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        let newBound = CGRect(
            x: self.bounds.origin.x - addedTouchArea,
            y: self.bounds.origin.y - addedTouchArea,
            width: self.bounds.width + 2 * addedTouchArea,
            height: self.bounds.width + 2 * addedTouchArea
        )
        return newBound.contains(point)
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

}
