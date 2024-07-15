//
//  CountHeaderView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 15/7/24.
//

import Foundation
import UIKit

class CountHeaderView: BaseCollectionReusableView {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var refreshImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.refreshButton.setTitle("", for: .normal)
    }
    
    override func setupView(text: String) {
        self.titleLabel.text = text
    }
}
