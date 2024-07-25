//
//  Configs.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 25/7/24.
//

import Foundation

final class Configs {
    
    static let share = Configs()
    
    private init() {}
    
    var env: Enviroment {
        #if ENDPOINT_DEBUG
            return .dev
        #else
            return .release
        #endif
    }
}
