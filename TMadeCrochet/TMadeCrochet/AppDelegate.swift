//
//  AppDelegate.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 1/7/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tabbarViewController: TabbarViewController?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.setRootScreen()
        
        return true
    }
    
    func setRootScreen() {
        guard AppConstant.isFirstTime else {
            DataManager.shared.readJSONFromFile(fileName: "symbols", type: SymbolResponseData.self) { result in
                AppConstant.symbolResponseData = result
                SplashRouter().setupRootView()
            }
            return
        }
        SplashRouter().setupRootView()
    }

}

