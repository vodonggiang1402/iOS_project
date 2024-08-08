//
//  ListTutorialCollectionCell.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 2/8/24.
//

import Foundation
import UIKit


class ListTutorialCollectionCell: BaseCollectionViewCell {
    
    @IBOutlet weak var imageContainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageContainView.layer.cornerRadius = 8.0
        self.imageContainView.layer.masksToBounds = true
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? TutorialItem else { return }
        self.titleLabel.text = model.itemName?.Localizable()
        self.desLabel.text = model.itemDes?.Localizable()
        self.imageContainView.backgroundColor = UIColor(hexString: model.itemColor ?? "") 
    }
}
