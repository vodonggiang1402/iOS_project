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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? Symbol else { return }
        self.titleLabel.text = model.symbolName
    }
}
