//
//  CountHeaderView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 15/7/24.
//

import Foundation
import UIKit

protocol CountHeaderViewDelegate: AnyObject {
    func refreshButtonAction()
}

class CountHeaderView: BaseCollectionReusableView {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var refreshImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: CountHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.systemFont(ofSize: AppConstant.headerTitleSize1)
        self.refreshButton.setTitle("", for: .normal)
    }
    
    override func setupView(text: String, imageStr: String) {
        self.titleLabel.text = text
        self.imageView.image = UIImage.init(named: imageStr)
    }
    @IBAction func refreshButtonAction(_ sender: Any) {
        self.delegate?.refreshButtonAction()
    }
}
