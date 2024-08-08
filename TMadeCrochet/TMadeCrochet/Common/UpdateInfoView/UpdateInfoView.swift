//
//  UpdateInfoView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 7/8/24.
//

import Foundation


import Foundation
import UIKit

class UpdateInfoView: BaseCollectionReusableView {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.systemFont(ofSize: AppConstant.headerTitleSize1)
    }
    
    override func setupView(text: String, imageStr: String) {
        self.titleLabel.text = text
    }
}
