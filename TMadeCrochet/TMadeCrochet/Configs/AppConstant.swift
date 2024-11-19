//
//  AppConstant.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 12/7/24.
//

import Foundation
import UIKit

struct AppConstant {
    static let navigationTitleSize: CGFloat = 20
    static let headerTitleSize1: CGFloat = 18
    static let headerTitleSize2: CGFloat = 17
    static let contentTextSize: CGFloat = 16
    static let testDeviceIdentifiers = "83e18d4b12a81912a807ce957ab91419"
    static let globalCount = 5
    static let adsOpenAppCount = 3
    static let adsTurorialCount = 5
    static let globalVideoCount = 5
    static let mailContact = "tmadeapp@gmail.com"
    static let phoneContact = "+84357798368"
    static let youtubeContact = "tmade-0705"
    static var tmadeAppLink: String { get { return "itms-apps://itunes.apple.com/app//id6560104490" } }
    
    
    static var countShowAdsWhenAddMoreCount: Int? {
        get { UserDefaults.standard.value(forKey: "count-show-ads-when-add-more-count") as? Int }
        set { UserDefaults.standard.setValue(newValue, forKey: "count-show-ads-when-add-more-count") }
    }
    
    static var countShowAdsWhenResetGlobalCount: Int? {
        get { UserDefaults.standard.value(forKey: "count-show-ads-when-reset-global-count") as? Int }
        set { UserDefaults.standard.setValue(newValue, forKey: "count-show-ads-when-reset-global-count") }
    }
    
    static var countShowAdsOpenApp: Int? {
        get { UserDefaults.standard.value(forKey: "count-show-ads-open-app") as? Int }
        set { UserDefaults.standard.setValue(newValue, forKey: "count-show-ads-open-app") }
    }
    
    static var countShowAdsWhenOpenTutorial: Int? {
        get { UserDefaults.standard.value(forKey: "count-show-ads-when-open-tutorial") as? Int }
        set { UserDefaults.standard.setValue(newValue, forKey: "count-show-ads-when-open-tutorial") }
    }
    
    static var isFirstTime: Bool {
        get { UserDefaults.standard.bool(forKey: "is-first-time") }
        set { UserDefaults.standard.setValue(newValue, forKey: "is-first-time") }
    }
    
    static var updateDataVersion1_0_1: Bool {
        get { UserDefaults.standard.bool(forKey: "update-data-version-1-0-2") }
        set { UserDefaults.standard.setValue(newValue, forKey: "update-data-version-1-0-2") }
    }
    
    static var symbolResponseData: SymbolResponseData? {
        get {
            guard let data = UserDefaults.standard.value(forKey: "symbol-response-data") as? Data,
                  let symbolResponseData = try? PropertyListDecoder().decode(SymbolResponseData.self, from: data) else { return nil }
            return symbolResponseData
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            UserDefaults.standard.setValue(data, forKey: "symbol-response-data")
        }
    }
    
    static var countResponseData: CountResponseData? {
        get {
            guard let data = UserDefaults.standard.value(forKey: "count-response-data") as? Data,
                  let countResponseData = try? PropertyListDecoder().decode(CountResponseData.self, from: data) else { return nil }
            return countResponseData
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            UserDefaults.standard.setValue(data, forKey: "count-response-data")
        }
    }
    
    static var tutorialResponseData: TutorialResponseData? {
        get {
            guard let data = UserDefaults.standard.value(forKey: "tutorial-response-data") as? Data,
                  let tutorialResponseData = try? PropertyListDecoder().decode(TutorialResponseData.self, from: data) else { return nil }
            return tutorialResponseData
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            UserDefaults.standard.setValue(data, forKey: "tutorial-response-data")
        }
    }
    
    static var localeId: String {
        get {
            let langIds = Bundle.main.localizations.filter({$0 != "en" && $0 != "vi"})
            let currentShortId = Locale.current.languageCode ?? "vi"
            let currentId = langIds.first(where: {$0.hasPrefix(currentShortId)}) ?? "vi"
            return UserDefaults.standard.value(forKey: "selected_language") as? String ?? currentId
        }
        set { UserDefaults.standard.setValue(newValue, forKey: "selected_language") }
    }
    
    static var appVersion: String {
        guard let releaseVersion = Bundle.main.releaseVersionNumber else { return ""}
        return releaseVersion
    }
    
    struct Ads {
        static var openAppAdsId: String {
            if Configs.share.env == .dev {
                return "ca-app-pub-3940256099942544/5575463023"
            } else {
                return "ca-app-pub-9183925814024348/5678293235"
            }
        }
        
        static var interstitialAdsId: String {
            if Configs.share.env == .dev {
                return "ca-app-pub-3940256099942544/4411468910"
            } else {
                return "ca-app-pub-9183925814024348/7264537763"
            }
        }
        
        static var bannerAdsId: String {
            if Configs.share.env == .dev {
                return "ca-app-pub-3940256099942544/2435281174"
            } else {
                return "ca-app-pub-9183925814024348/8440187943"
            }
        }
       
    }

}
