//
//  SymbolResponse.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 3/7/24.
//

import Foundation

struct SymbolResponseData: Codable {
    var data: [[Symbol]]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decodeIfPresent([[Symbol]].self, forKey: .data)
    }
 
    init(newData: [[Symbol]]) {
        self.data = newData
    }
}

struct Symbol : Codable {
    var symbolId: String?
    var symbolName: String?
    var symbolDes: String?
    var iconName: String?
    var videoUrl: String?
    var backgroundColor: String?
    var isAds: Bool?
    var steps: [SymbolStep]?
    var videoCount: Int?
    enum CodingKeys: String, CodingKey {
        case symbolId = "symbol_id"
        case symbolName = "symbol_name"
        case symbolDes = "symbol_des"
        case iconName = "icon_name"
        case videoUrl = "video_url"
        case isAds = "is_ads"
        case steps = "steps"
        case backgroundColor = "background_color"
        case videoCount = "video_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbolId = try? container.decodeIfPresent(String.self, forKey: .symbolId)
        symbolName = try? container.decodeIfPresent(String.self, forKey: .symbolName)
        symbolDes = try? container.decodeIfPresent(String.self, forKey: .symbolDes)
        iconName = try? container.decodeIfPresent(String.self, forKey: .iconName)
        videoUrl = try? container.decodeIfPresent(String.self, forKey: .videoUrl)
        isAds = try? container.decodeIfPresent(Bool.self, forKey: .isAds)
        steps = try? container.decodeIfPresent([SymbolStep].self, forKey: .steps)
        backgroundColor = try? container.decodeIfPresent(String.self, forKey: .backgroundColor)
        videoCount = try? container.decodeIfPresent(Int.self, forKey: .videoCount)
    }
}

struct SymbolStep : Codable {
    var stepName: String?
    var content: String?
    var imageName: String?
    
    enum CodingKeys: String, CodingKey {
        case stepName = "step_name"
        case content = "content"
        case imageName = "image_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stepName = try? container.decodeIfPresent(String.self, forKey: .stepName)
        content = try? container.decodeIfPresent(String.self, forKey: .content)
        imageName = try? container.decodeIfPresent(String.self, forKey: .imageName)
    }
}
