//
//  UITabbar_Ext.swift
//  Earable
//
//  Created by Vo Dong Giang on 1/7/24.
//  Copyright © 2020 Earable. All rights reserved.
//

import UIKit

let defaultTabbarHeight: CGFloat = 60.0

enum TabBarItem {
    case count
    case symbol
    case pattern
    case setting
    
    var selectedImage: UIImage? {
        switch self {
        case .count:
            return UIImage(named: "ico_home_active")
        case .symbol:
            return UIImage(named: "ico_exchange_active")
        case .pattern:
            return UIImage(named: "ico_history_active")
        case .setting:
            return UIImage(named: "ico_setting_active")
        }
    }
    
    var unselectedImage: UIImage? {
        switch self {
        case .count:
            return UIImage(named: "ico_home_active")
        case .symbol:
            return UIImage(named: "ico_exchange")
        case .pattern:
            return UIImage(named: "ico_history")
        case .setting:
            return UIImage(named: "ico_setting")
        }
    }
    
    var title: String {
        switch self {
        case .count:
            return "Đếm"
        case .symbol:
            return "Mũi"
        case .pattern:
            return "Knitting"
        case .setting:
            return "Setting"
        }
    }
    
    var rawIndex: Int {
        switch self {
        case .count:
            return 0
        case .symbol:
            return 1
        case .pattern:
            return 2
        case .setting:
            return 3
        }
    }
}
