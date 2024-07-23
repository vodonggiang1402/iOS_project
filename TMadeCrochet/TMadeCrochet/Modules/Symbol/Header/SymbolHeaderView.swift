//
//  HeaderViewCV.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 10/7/24.
//

import Foundation
import UIKit

class SymbolHeaderView: BaseCollectionReusableView {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setupView(text: String, imageStr: String) {
        self.titleLabel.text = text
        self.imageView.image = UIImage.init(named: imageStr)
    }
}
