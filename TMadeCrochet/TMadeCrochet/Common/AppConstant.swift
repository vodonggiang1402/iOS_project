//
//  AppConstant.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 12/7/24.
//

import Foundation
import UIKit

struct AppConstant {
    
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
}
