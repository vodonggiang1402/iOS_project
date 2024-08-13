//
//  AppDelegate.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 1/7/24.
//

import UIKit
import GoogleMobileAds
import Firebase
import FirebaseCore
import FirebaseCrashlytics
import FirebaseAnalytics

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
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        if Configs.share.env == .dev {
            GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [AppConstant.testDeviceIdentifiers]
        }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
      
    }
    
    func showAdsOpenApp() {
        // Show the app open ad when the app is foregrounded.
          if let count = AppConstant.countShowAdsOpenApp, count > 0 {
              if count >= AppConstant.adsOpenAppCount {
                  tabbarViewController?.loadAds()
                  AppConstant.countShowAdsOpenApp = 1
              } else {
                  let newCount = count + 1
                  AppConstant.countShowAdsOpenApp = newCount
              }
          } else {
              AppConstant.countShowAdsOpenApp = 1
          }
    }
    
    func setRootScreen() {
        Analytics.setDefaultEventParameters([
          "start_app": "SetupRootView"
        ])
        SplashRouter().setupRootView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showAdsOpenApp()
        }
    }

}

