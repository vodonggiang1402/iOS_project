//
//  TutorialCollectionCell.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 1/8/24.
//

import Foundation
import UIKit


class TutorialCollectionCell: BaseCollectionViewCell {
    
    @IBOutlet weak var imageContainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageContainView.layer.cornerRadius = 8.0
        self.imageContainView.layer.masksToBounds = true
        
        self.imageView.layer.cornerRadius = 8.0
        self.imageView.layer.masksToBounds = true
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? Tuttorial else { return }
        self.titleLabel.text = model.tutorialName?.Localizable()
    }
}
