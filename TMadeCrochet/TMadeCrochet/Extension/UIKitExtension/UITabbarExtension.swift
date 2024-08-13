//
//  UITabbar_Ext.swift
//  Earable
//
//  Created by Vo Dong Giang on 1/7/24.
//  Copyright © 2020 Earable. All rights reserved.
//

import UIKit

let defaultTabbarHeight: CGFloat = 64.0

enum TabBarItem {
    case count
    case symbol
    case tutorial
    case setting
    
    var selectedImage: UIImage? {
        switch self {
        case .count:
            return UIImage(named: "ico_count_active")
        case .symbol:
            return UIImage(named: "ico_symbol_active")
        case .tutorial:
            return UIImage(named: "ico_tutorial_active")
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
        case .tutorial:
            return UIImage(named: "ico_tutorial_inactive")
        case .setting:
            return UIImage(named: "ico_setting_inactive")
        }
    }
    
    var title: String {
        switch self {
        case .count:
            return "tabbar_item_count_text".Localizable()
        case .symbol:
            return "tabbar_item_symbol_text".Localizable()
        case .tutorial:
            return "tabbar_item_tutorial_text".Localizable()
        case .setting:
            return "tabbar_item_setting_text".Localizable()
        }
    }
    
    var rawIndex: Int {
        switch self {
        case .symbol:
            return 0
        case .count:
            return 1
        case .tutorial:
            return 2
        case .setting:
            return 3
        }
    }
}
