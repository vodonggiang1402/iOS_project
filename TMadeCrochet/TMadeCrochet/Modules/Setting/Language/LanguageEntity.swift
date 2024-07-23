//
//  LanguageEntity.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class LanguageEntity: InteractorToEntityLanguageProtocol {
   
}

struct Language {
    var id: String
    var name: String
    var isSelected: Bool? = false
    
    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.id == rhs.id
    }
}
