//
//  CountHeaderView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 15/7/24.
//

import Foundation
import UIKit

protocol CountHeaderViewDelegate: AnyObject {
    func refreshButtonAction(indexPath: IndexPath)
}

class CountHeaderView: BaseCollectionReusableView {
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: CountHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.refreshButton.setTitle("", for: .normal)
    }
    
    override func setupView(text: String) {
        self.titleLabel.text = text
    }
    @IBAction func refreshButtonAction(_ sender: Any) {
        self.delegate?.refreshButtonAction(indexPath: IndexPath(row: 0, section: 0))
    }
}
