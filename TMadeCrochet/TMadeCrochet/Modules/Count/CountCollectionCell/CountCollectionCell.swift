//
//  CountCollectionCell.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 13/7/24.
//

import Foundation
import UIKit

class CountCollectionCell: BaseCollectionViewCell {
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.moreButton.setTitle("", for: .normal)
        self.minusButton.setTitle("", for: .normal)
        self.plusButton.setTitle("", for: .normal)
        
        self.containView.layer.cornerRadius = 10
        self.containView.layer.borderWidth = 1
        self.containView.layer.borderColor = UIColor.gray.cgColor
        self.containView.layer.masksToBounds = true
    }
    
}
