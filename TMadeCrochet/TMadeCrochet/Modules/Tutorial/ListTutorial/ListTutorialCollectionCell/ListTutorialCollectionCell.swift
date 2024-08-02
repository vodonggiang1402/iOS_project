//
//  ListTutorialCollectionCell.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 2/8/24.
//

import Foundation
import UIKit


class ListTutorialCollectionCell: BaseCollectionViewCell {
    
//    @IBOutlet weak var imageContainView: UIView!
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? Tutorial else { return }
        
    }
}
