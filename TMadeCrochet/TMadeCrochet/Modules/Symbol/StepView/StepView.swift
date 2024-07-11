//
//  StepView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 11/7/24.
//

import Foundation
import UIKit

class StepView: BaseView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, imageName: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.imageView.image = UIImage.init(named: imageName)
    }
    

}
