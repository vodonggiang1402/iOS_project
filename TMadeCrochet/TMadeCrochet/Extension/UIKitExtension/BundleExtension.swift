//
//  BundleExtension.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 24/7/24.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
