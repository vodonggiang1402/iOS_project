//
//  CountFooterView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 15/7/24.
//

import Foundation
import UIKit

protocol CountFooterViewDelegate: AnyObject {
    func addButtonAction()
}

class CountFooterView: BaseCollectionReusableView {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    weak var delegate: CountFooterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setupView(text: String, imageStr: String) {
        self.addButton.setTitle("add_more_text".Localizable(), for: .normal)
        self.titleLabel.text = text
        self.imageView.image = UIImage.init(named: imageStr)
    }
    @IBAction func addButtonAction(_ sender: Any) {
        self.delegate?.addButtonAction()
    }
}
