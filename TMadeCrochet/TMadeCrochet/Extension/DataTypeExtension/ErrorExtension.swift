//
//  ErrorExtension.swift
//  Probit
//
//  Created by Vo Dong Giang on 1/7/24.
//

import Foundation

enum TypeCastingError: Error {
    case NilResult
    case WrongTypeCasting(message: String)
    case WrongStoryboardName(message: String)
    case ConvertingJSONError(message: String)
}

enum BaseError: Error {
    case NotImplementedException
}
