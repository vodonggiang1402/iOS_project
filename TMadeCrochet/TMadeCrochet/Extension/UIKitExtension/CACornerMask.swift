//
//  CACornerMask.swift
//  Probit
//
//  Created by Vo Dong Giang on 30/5/24.
//

import Foundation
import QuartzCore

extension CACornerMask {
    static var topLeft: CACornerMask {
        get {
            return CACornerMask.layerMinXMinYCorner
        }
    }

    static var topRight: CACornerMask {
        get {
            return CACornerMask.layerMaxXMinYCorner
        }
    }

    static var bottomLeft: CACornerMask {
        get {
            return CACornerMask.layerMinXMaxYCorner
        }
    }

    static var bottomRight: CACornerMask {
        get {
            return CACornerMask.layerMaxXMaxYCorner
        }
    }
}
