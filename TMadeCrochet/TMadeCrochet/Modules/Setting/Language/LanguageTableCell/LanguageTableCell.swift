//
//  LanguageTableCell.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 23/7/24.
//

import Foundation
import UIKit

class LanguageTableViewCell: BaseTableViewCell {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setupCell(object: Any) {
        guard let model = object as? Language,
              let isSelected = model.isSelected else { return }
        languageLabel.font = isSelected ? .medium(size: 16) : .primary(size: 16)
        languageLabel.text = model.name.firstUppercased
        languageLabel.textColor = isSelected ? UIColor.color_5b5b5b_dadada : UIColor.color_7f7f7f_565656
        checkImage.isHidden = !(isSelected)
        isUserInteractionEnabled = !(isSelected)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

