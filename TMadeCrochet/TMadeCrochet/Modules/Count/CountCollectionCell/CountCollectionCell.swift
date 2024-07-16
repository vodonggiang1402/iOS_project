//
//  CountCollectionCell.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 13/7/24.
//

import Foundation
import UIKit

protocol CountCollectionCellDelegate: AnyObject {
    func minusTap(indexPath: IndexPath)
    func plusTap(indexPath: IndexPath)
}

class CountCollectionCell: BaseCollectionViewCell {
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    weak var delegate: CountCollectionCellDelegate?
    var currentIndexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.moreButton.setTitle("", for: .normal)
        self.minusButton.setTitle("", for: .normal)
        self.plusButton.setTitle("", for: .normal)
        
        self.containView.layer.cornerRadius = 15
        self.containView.layer.borderWidth = 0.5
        self.containView.layer.masksToBounds = true
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? Count else { return }
        self.titleLabel.text = model.countName 
        self.countLabel.text = model.count?.asString()
        if let isGlobal = model.isGlobal, isGlobal {
            self.moreButton.isHidden = isGlobal ? true : false
        }
        self.containView.layer.borderColor = UIColor(hexString: model.color ?? "").cgColor
    }
    
    @IBAction func minusAction(_ sender: Any) {
        if let indexPath = self.currentIndexPath {
            self.delegate?.minusTap(indexPath: indexPath)
        }
    }
    
    
    @IBAction func plusAction(_ sender: Any) {
        if let indexPath = self.currentIndexPath {
            self.delegate?.plusTap(indexPath: indexPath)
        }
    }
}
