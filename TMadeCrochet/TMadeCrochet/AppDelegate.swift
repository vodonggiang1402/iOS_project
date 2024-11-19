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
import FirebaseMessaging

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
        
        // 2
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        if Configs.share.env == .dev {
            GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [AppConstant.testDeviceIdentifiers]
        }
        
        // 1
        UNUserNotificationCenter.current().delegate = self
        // 2
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions) { _, _ in }
        // 3
        application.registerForRemoteNotifications()
        
        
        Messaging.messaging().delegate = self
        
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
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      Messaging.messaging().apnsToken = deviceToken
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler:
    @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([[.banner, .sound]])
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    completionHandler()
  }
}

extension AppDelegate: MessagingDelegate {
  func messaging(
    _ messaging: Messaging,
    didReceiveRegistrationToken fcmToken: String?
  ) {
    let tokenDict = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: tokenDict)
  }
}
