//
//  TutorialResponse.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 31/7/24.
//

import Foundation

struct TutorialResponseData: Codable {
    var data: [Tutorial]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decodeIfPresent([Tutorial].self, forKey: .data)
    }
}

struct Tutorial : Codable {
    var tutorialName: String?
    var tutorialDes: String?
    var tutorialImage: String?
    var color: String?
    var list: [TutorialItem]?
        
    enum CodingKeys: String, CodingKey {
        case tutorialName = "tutorial_name"
        case tutorialDes = "tutorial_des"
        case tutorialImage = "tutorial_image"
        case color = "color"
        case list = "list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tutorialName = try? container.decodeIfPresent(String.self, forKey: .tutorialName)
        tutorialDes = try? container.decodeIfPresent(String.self, forKey: .tutorialDes)
        tutorialImage = try? container.decodeIfPresent(String.self, forKey: .tutorialImage)
        color = try? container.decodeIfPresent(String.self, forKey: .color)
        list = try? container.decodeIfPresent([TutorialItem].self, forKey: .list)
    }
}

struct TutorialItem : Codable {
    var itemName: String?
    var itemDes: String?
    var itemImage: String?
    var itemColor: String?
    
    enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case itemDes = "item_des"
        case itemImage = "item_image"
        case itemColor = "item_color"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemName = try? container.decodeIfPresent(String.self, forKey: .itemName)
        itemDes = try? container.decodeIfPresent(String.self, forKey: .itemDes)
        itemImage = try? container.decodeIfPresent(String.self, forKey: .itemImage)
        itemColor = try? container.decodeIfPresent(String.self, forKey: .itemColor)
    }
}
