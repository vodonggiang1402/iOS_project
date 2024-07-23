//
//  ArrayExtension.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 23/7/24.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    func at(_ index: Int) -> Element? {
        if index < 0 || index > self.count - 1 {
            return nil
        }
        return self[index]
    }
    
    mutating func rearrange(fromIndex: Int, toIndex: Int) {
        let element = self.remove(at: fromIndex)
        self.insert(element, at: toIndex)
    }
}
