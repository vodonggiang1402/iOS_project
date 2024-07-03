//
//  BaseService.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 3/7/24.
//

import Foundation

class DataManager  {
    static let shared = DataManager()
    
    func readJSONFromFile<T: Decodable>(fileName: String, type: T.Type, completionHandler:@escaping (T?)-> Void) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                completionHandler(jsonData)
            } catch {
                print("error:\(error)")
            }
        }
        completionHandler(nil)
    }
}
