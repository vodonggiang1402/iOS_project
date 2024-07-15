//
//  StringExtension.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 1/7/24.
//

import Foundation

extension String {
    var asTrimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
