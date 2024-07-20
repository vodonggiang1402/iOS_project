//
//  AppDelegate.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 1/7/24.
//

import UIKit
import GoogleMobileAds

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
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "83e18d4b12a81912a807ce957ab91419" ]
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Show the app open ad when the app is foregrounded.
        AppOpenAdManager.shared.showAdIfAvailable()
      }
    
    func setRootScreen() {
        SplashRouter().setupRootView()
    }

}

