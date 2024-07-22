
import UIKit

extension UIImageView {
    func setTintImageView(imageName: String, colorTint: UIColor) {
        let tintImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.image = tintImage
        self.tintColor = colorTint
    }
}
