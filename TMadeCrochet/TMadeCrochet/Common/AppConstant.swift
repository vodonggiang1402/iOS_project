//
//  AppConstant.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 12/7/24.
//

import Foundation
import UIKit

struct AppConstant {
    static let testDeviceIdentifiers = "83e18d4b12a81912a807ce957ab91419"
    static let openAppAdId = "ca-app-pub-3940256099942544/5575463023"
    static let symbolAdId = "ca-app-pub-3940256099942544/4411468910"
    static let globalCount = 3
    
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
    
    static var isFirstTime: Bool {
        get { UserDefaults.standard.bool(forKey: "is-first-time") }
        set { UserDefaults.standard.setValue(newValue, forKey: "is-first-time") }
    }
    
    static var symbolResponseData: SymbolResponseData? {
        get {
            guard let data = UserDefaults.standard.value(forKey: "symbol-response-data") as? Data,
                  let tfaListResponse = try? PropertyListDecoder().decode(SymbolResponseData.self, from: data) else { return nil }
            return tfaListResponse
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            UserDefaults.standard.setValue(data, forKey: "symbol-response-data")
        }
    }
    
    static var countResponseData: CountResponseData? {
        get {
            guard let data = UserDefaults.standard.value(forKey: "count-response-data") as? Data,
                  let tfaListResponse = try? PropertyListDecoder().decode(CountResponseData.self, from: data) else { return nil }
            return tfaListResponse
        }
        set {
            guard let data = try? PropertyListEncoder().encode(newValue) else { return }
            UserDefaults.standard.setValue(data, forKey: "count-response-data")
        }
    }
}
