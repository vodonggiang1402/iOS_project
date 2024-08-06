//
//  UIImageExtension.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 6/8/24.
//

import UIKit

extension UIImage {
    func addWatermark(_ text: String, color: UIColor = UIColor.color_main_app_pink.withAlphaComponent(0.07)) -> UIImage {
           let fontSize = 20.0
           let stringArray =  [String](repeating: text, count: 100)
           let longString = stringArray.joined(separator: "     ")
           let renderer = UIGraphicsImageRenderer(size: size)
           let watermarkedImage = renderer.image { context in
               draw(at: .zero)
               let attributes: [NSAttributedString.Key: Any] = [
                   .font: UIFont.systemFont(ofSize: fontSize),
                   .foregroundColor: color
               ]
               let textSize = longString.size(withAttributes: attributes)
               
               // Calculate the center position
               let centerX = (size.width - textSize.width) / 2
               let centerY = (size.height - textSize.height) / 2
               
               // Calculate the center point of the text
               let centerPoint = CGPoint(x: centerX + textSize.width / 2, y: centerY + textSize.height / 2)
               
               let renderedTextSize = text.size(withAttributes: attributes)
               print(renderedTextSize)
               
               // Rotate the context around the center point by 45 degrees
               context.cgContext.translateBy(x: centerPoint.x, y: centerPoint.y)
               context.cgContext.rotate(by: -CGFloat.pi / 10) // 45 degrees in radians
               context.cgContext.translateBy(x: -centerPoint.x, y: -centerPoint.y)
               
               let textRect = CGRect(
                   x: -size.width * 0.4,
                   y: -fontSize,
                   width: size.width * 2,
                   height: size.height * 1.2
               )
               longString.draw(in: textRect, withAttributes: attributes)
           }
           return watermarkedImage
       }
}
