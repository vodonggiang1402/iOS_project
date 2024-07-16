//
//  CountCollectionCell.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 13/7/24.
//

import Foundation
import UIKit

protocol CountCollectionCellDelegate: AnyObject {
    func minusButtonTap(indexPath: IndexPath)
    func plusButtonTap(indexPath: IndexPath)
    func moreButtonTap(indexPath: IndexPath)
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
        self.moreButton.isHidden = model.isGlobal ?? false ? true : false
        self.containView.layer.borderColor = UIColor(hexString: model.color ?? "").cgColor
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        if let indexPath = self.currentIndexPath {
            self.delegate?.minusButtonTap(indexPath: indexPath)
        }
    }
    
    
    @IBAction func plusButtonAction(_ sender: Any) {
        if let indexPath = self.currentIndexPath {
            self.delegate?.plusButtonTap(indexPath: indexPath)
        }
    }
    
    @IBAction func moreButtonAction(_ sender: Any) {
        if let indexPath = self.currentIndexPath {
            self.delegate?.moreButtonTap(indexPath: indexPath)
        }
    }
}
