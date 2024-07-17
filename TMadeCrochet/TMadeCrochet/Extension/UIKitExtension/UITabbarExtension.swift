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
            return UIImage(named: "ico_count_active")
        case .symbol:
            return UIImage(named: "ico_symbol_active")
        case .pattern:
            return UIImage(named: "ico_pattern_active")
        case .setting:
            return UIImage(named: "ico_setting_active")
        }
    }
    
    var unselectedImage: UIImage? {
        switch self {
        case .count:
            return UIImage(named: "ico_count_inactive")
        case .symbol:
            return UIImage(named: "ico_symbol_inactive")
        case .pattern:
            return UIImage(named: "ico_pattern_inactive")
        case .setting:
            return UIImage(named: "ico_setting_inactive")
        }
    }
    
    var title: String {
        switch self {
        case .count:
            return "Bộ đếm"
        case .symbol:
            return "Mũi móc"
        case .pattern:
            return "Mẫu móc"
        case .setting:
            return "Cài đặt"
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
