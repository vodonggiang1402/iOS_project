//
//  StringExtension.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 1/7/24.
//

import Foundation

extension String {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    
    var asTrimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func Localizable(langCode: String = AppConstant.localeId) -> String {
        guard let path = Bundle.main.path(forResource: langCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return ""
        }
        var text = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        text = convertKotlinToSwiftString(originalStr: text)
        return text.isActuallyEmpty ? Localizable(langCode: "en-US") : text
    }
    
    func convertKotlinToSwiftString(originalStr: String) -> String {
        var regex_search_term: String = "\\$(d|D|li|s|f)"
        var regex_replacement: String = "\\$@"
        var finalString = originalStr
        if let regex = try? NSRegularExpression(pattern: regex_search_term, options: NSRegularExpression.Options.caseInsensitive) {
            let range = NSMakeRange(0, originalStr.count)
            finalString = regex.stringByReplacingMatches(in: originalStr, options: [], range: range, withTemplate: regex_replacement)
        }
        regex_search_term = "%%"
        regex_replacement = "%"
        if let regex = try? NSRegularExpression(pattern: regex_search_term, options: NSRegularExpression.Options.caseInsensitive) {
            let range = NSMakeRange(0, finalString.count)
            finalString = regex.stringByReplacingMatches(in: finalString, options: [], range: range, withTemplate: regex_replacement)
        }
        return finalString
    }
    
    var isActuallyEmpty: Bool {
        return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).isEmpty
    }
}
