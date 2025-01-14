//
//  UIColorExtension.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 1/7/24.
//

import UIKit

extension UIColor {
    public convenience init(rgb: (r: CGFloat, g: CGFloat, b: CGFloat)) {
        self.init(red: rgb.r/255, green: rgb.g/255, blue: rgb.b/255, alpha: 1.0)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func as1ptImage(height: CGFloat = 0.5) -> UIImage {
        UIGraphicsBeginImageContext(CGSize.init(width: 1, height: height))
        guard let ctx = UIGraphicsGetCurrentContext() else { return UIImage() }
        self.setFill()
        ctx.fill(CGRect(x: 0, y: 0, width: 1, height: height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
    
    func tabBarImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize.init(width: 1, height: 49))
        guard let ctx = UIGraphicsGetCurrentContext() else { return UIImage() }
        self.setFill()
        ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 49))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
    
    func navBarImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize.init(width: 1, height: 88))
        guard let ctx = UIGraphicsGetCurrentContext() else { return UIImage() }
        self.setFill()
        ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 88))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIColor {
    func generateThemeColor(name: String) -> UIColor {
        return UIColor.init(named: name) ?? .clear
    }
    
    static let color_f5f5f5_282828 = UIColor().generateThemeColor(name: "color_f5f5f5_282828")
    static let color_fafafa_1818181 = UIColor().generateThemeColor(name: "color_fafafa_181818")
    static let color_989898_868686 = UIColor().generateThemeColor(name: "color_989898_868686")
    static let color_232323_fafafa = UIColor().generateThemeColor(name: "color_232323_fafafa")
    static let color_main = UIColor().generateThemeColor(name: "color_main")
    static let color_background_main = UIColor().generateThemeColor(name: "color_background_main")
    static let color_main_app_gray = UIColor().generateThemeColor(name: "color_main_app_gray")
    static let color_main_app_pink = UIColor().generateThemeColor(name: "color_main_app_pink")
    static let color_a3a3a3_6e6e6e = UIColor().generateThemeColor(name: "color_a3a3a3_6e6e6e")
    static let color_7f7f7f_565656 = UIColor().generateThemeColor(name: "color_7f7f7f_565656")
    static let color_5b5b5b_dadada = UIColor().generateThemeColor(name: "color_5b5b5b_dadada")
    static let color_b6b6b6_7b7b7b = UIColor().generateThemeColor(name: "color_b6b6b6_7b7b7b")
}

extension UIColor {
    func toHexString() -> String{
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        let hexString = String.init(format: "#%02lX%02lX%02lX",
                                    lroundf(Float(r * 255)),
                                    lroundf(Float(g * 255)),
                                    lroundf(Float(b * 255)))
        return hexString
    }
}

extension UIColor {
    var light: UIColor {
        let lightAppearance = UITraitCollection(userInterfaceStyle: .light)
        return self.resolvedColor(with: lightAppearance)
    }

    var dark: UIColor {
        let darkAppearance = UITraitCollection(userInterfaceStyle: .dark)
        return self.resolvedColor(with: darkAppearance)
    }
}
