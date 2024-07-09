//
//  SymbolCollectionCell.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 3/7/24.
//

import Foundation
import UIKit

class SymbolCollectionCell: BaseCollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containView: UIView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containView.backgroundColor = UIColor.color_989898_868686
        self.containView.layer.cornerRadius = 10
        self.containView.layer.masksToBounds = true
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? Symbol else { return }
        self.titleLabel.text = model.symbolName
        self.iconImageView.image = UIImage.init(named: model.iconName ?? "")
    }
}
