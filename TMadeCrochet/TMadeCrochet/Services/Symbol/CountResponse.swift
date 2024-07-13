//
//  CountResponse.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 13/7/24.
//

import Foundation

struct CountResponseData: Codable {
    var data: [[Count]]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decodeIfPresent([[Count]].self, forKey: .data)
    }
}

struct Count : Codable {
    var isGlobal: Bool?
    var countName: String?
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case isGlobal = "is_global"
        case countName = "count_name"
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isGlobal = try? container.decodeIfPresent(Bool.self, forKey: .isGlobal)
        countName = try? container.decodeIfPresent(String.self, forKey: .countName)
        count = try? container.decodeIfPresent(Int.self, forKey: .count)
    }
}
