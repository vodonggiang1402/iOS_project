//
//  UIFont.swift

import UIKit

extension UIFont {

    enum FontStyles {
        case regular, italic, bold, medium
        var name: String {
            switch self {
            case .regular: return "SF Pro Display Regular"
            case .italic:  return "SF Pro Display Italic"
            case .bold:    return "SF Pro Display Bold"
            case .medium:  return "SF Pro Display Medium"
            }
        }
    }
    
    enum RawFontStyles {
        case regular, italic, bold, medium
        var name: String {
            switch self {
            case .regular: return "Regular"
            case .italic:  return "Italic"
            case .bold:    return "Bold"
            case .medium:  return "Medium"
            }
        }
    }
    
    /// Gets the font style (face) name
    var fontStyle: String {
        return fontFace
    }

    /// Gets the font face name
    var fontFace: String {
        return (fontDescriptor.object(forKey: .face) as? String) ?? fontDescriptor.postscriptName
    }
    
    static func font(style: FontStyles, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: style.name, size: size) else {
            // If we don't have the font, let's return at least the system's default on the requested size
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
        
    static func primary(size: CGFloat = 16) -> UIFont {
        font(style: .regular, size: size)
    }
    
    static func important(size: CGFloat = 16) -> UIFont {
        font(style: .bold, size: size)
    }
    
    static func medium(size: CGFloat = 16) -> UIFont {
        font(style: .medium, size: size)
    }
    
    static func isAppleFont(_ fontName: String) -> Bool {
        return fontName.starts(with: "SF Pro") || fontName.starts(with: "SF Compact") || fontName.starts(with: "SF Mono") || fontName.starts(with: "SF Arabic") || fontName.starts(with: "New York")
    }
    
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
    var monospacedDigitFont: UIFont {
           let oldFontDescriptor = fontDescriptor
           let newFontDescriptor = oldFontDescriptor.monospacedDigitFontDescriptor
           return UIFont(descriptor: newFontDescriptor, size: 0)
    }
}

private extension UIFontDescriptor {
    var monospacedDigitFontDescriptor: UIFontDescriptor {
        let fontDescriptorFeatureSettings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
        return fontDescriptor
    }
}
