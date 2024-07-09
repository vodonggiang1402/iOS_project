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
<<<<<<< HEAD
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containView: UIView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containView.backgroundColor = UIColor.color_989898_868686
        self.containView.layer.cornerRadius = 10
=======
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containView.layer.cornerRadius = 8.0
>>>>>>> 8c2e4b557964b03a8f97dc11eb6a6d3bf10bda14
        self.containView.layer.masksToBounds = true
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? Symbol else { return }
        self.titleLabel.text = model.symbolName
<<<<<<< HEAD
        self.iconImageView.image = UIImage.init(named: model.iconName ?? "")
=======
        self.imageView.image = UIImage.init(named: model.iconName ?? "")
        self.containView.backgroundColor = UIColor(hexString: model.backgroundColor ?? "")
>>>>>>> 8c2e4b557964b03a8f97dc11eb6a6d3bf10bda14
    }
}
