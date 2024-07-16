//
//  CountFooterView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 16/7/24.
//

import Foundation
import UIKit

protocol AddCountFooterViewDelegate: AnyObject {
    func addButtonAction()
}
class AddCountFooterView: BaseCollectionReusableView {
    @IBOutlet weak var addButton: UIButton!
    weak var delegate: CountFooterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addButton.setTitle("Thêm", for: .normal)
        self.addButton.imageView?.contentMode = .scaleAspectFill
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        self.delegate?.addButtonAction()
    }
}
