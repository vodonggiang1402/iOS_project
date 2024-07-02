//
//  ErrorExtension.swift
//  Probit
//
//  Created by Nguyen Huy Hoang on 02/10/2023.
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
