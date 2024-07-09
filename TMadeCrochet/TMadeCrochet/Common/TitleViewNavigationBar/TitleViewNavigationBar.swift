//
//  TitleViewNavigationBar.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 8/7/24.
//

import UIKit

class TitleViewNavigationBar: BaseView {
    @IBOutlet weak var titleLabel: UILabel!
    func setupTitleView(title: String) {
        titleLabel.text = title
    }
}
