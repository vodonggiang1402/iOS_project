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
    @IBOutlet weak var addButton: UIButton!
    weak var delegate: CountFooterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setupView(text: String) {
        self.addButton.setTitle("Thêm", for: .normal)
        self.titleLabel.text = text
    }
    @IBAction func addButtonAction(_ sender: Any) {
        self.delegate?.addButtonAction()
    }
}
