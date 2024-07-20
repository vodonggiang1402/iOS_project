//
//  SymbolCollectionCell.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 3/7/24.
//

import Foundation
import UIKit

class SymbolCollectionCell: BaseCollectionViewCell {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var adsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containView.layer.cornerRadius = 8.0
        self.containView.layer.masksToBounds = true
        
        self.adsImageView.layer.cornerRadius = 8.0
        self.adsImageView.layer.masksToBounds = true
        
    }
    
    override func prepareForReuse() {
        adsImageView.image = nil
        imageView.image = nil
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? Symbol else { return }
        self.titleLabel.text = model.symbolName
        if let iconName = model.iconName, iconName.count > 0 {
            self.imageView.image = UIImage.init(named: iconName)
        }
        self.adsImageView.image = UIImage.init(named: "ico_clock")
        if let isAds = model.isAds, isAds {
            self.adsImageView.isHidden = false
        } else {
            self.adsImageView.isHidden = true
        }
        self.containView.backgroundColor = UIColor(hexString: model.backgroundColor ?? "")
    }
}
