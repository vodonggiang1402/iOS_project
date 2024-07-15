//
//  HeaderViewCV.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 10/7/24.
//

import Foundation
import UIKit

class SymbolHeaderView: BaseCollectionReusableView {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setupView(text: String) {
        self.titleLabel.text = text
    }
}
