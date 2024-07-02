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
    case home
    case symbol
    case knitting
    case save
    case setting
    
    var selectedImage: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "ico_home_active")
        case .symbol:
            return UIImage(named: "ico_exchange_active")
        case .knitting:
            return UIImage(named: "ico_history_active")
        case .save:
            return UIImage(named: "ico_wallet_active")
        case .setting:
            return UIImage(named: "ico_setting_active")
        }
    }
    
    var unselectedImage: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "ico_home")
        case .symbol:
            return UIImage(named: "ico_exchange")
        case .knitting:
            return UIImage(named: "ico_history")
        case .save:
            return UIImage(named: "ico_wallet")
        case .setting:
            return UIImage(named: "ico_setting")
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .symbol:
            return "Symbol"
        case .knitting:
            return "Knitting"
        case .save:
            return "Save"
        case .setting:
            return "Setting"
        }
    }
    
    var rawIndex: Int {
        switch self {
        case .home:
            return 0
        case .symbol:
            return 1
        case .knitting:
            return 2
        case .save:
            return 3
        case .setting:
            return 4
        }
    }
}
