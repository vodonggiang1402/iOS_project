//
//  SettingView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 22/7/24.
//

import Foundation
import UIKit

protocol ContactViewDelegate: AnyObject {
    func phoneViewNormalTap()
    func mailViewNormalTap()
    func youtubeViewNormalTap()
}

class ContactView: BaseView {
    @IBOutlet weak var phoneView: HighlightView!
    @IBOutlet weak var mailView: HighlightView!
    @IBOutlet weak var youtubeView: HighlightView!

    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var mailLabel: UILabel!
    @IBOutlet private weak var youtubeLabel: UILabel!

        
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var mailImageView: UIImageView!
    @IBOutlet weak var youtubeImageView: UIImageView!

    
    weak var delegate: ContactViewDelegate?
    
    override func localizedString() { 
        phoneLabel.text = AppConstant.phoneContact
        mailLabel.text = AppConstant.mailContact
        youtubeLabel.text = AppConstant.youtubeContact
    }
    
    override func setupUI() {
        
        phoneImageView.layer.cornerRadius = 5
        phoneImageView.layer.masksToBounds = true
        
        mailImageView.layer.cornerRadius = 5
        mailImageView.layer.masksToBounds = true
        
        youtubeImageView.layer.cornerRadius = 5
        youtubeImageView.layer.masksToBounds = true
        
        phoneView.delegate = self
        phoneView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.phoneViewNormalTap()
        }
        
        mailView.delegate = self
        mailView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.mailViewNormalTap()
        }
        
        youtubeView.delegate = self
        youtubeView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.youtubeViewNormalTap()
        }
        
    }
    
}

extension ContactView: HighlightViewProtocol {
    func highlight(view: HighlightView) {
        switch view {
        case phoneView:
            phoneLabel.textColor = UIColor.color_7f7f7f_565656
            phoneImageView.setTintImageView(imageName: "ico_phone",
                                              colorTint: UIColor.clear)
        case mailView:
            mailLabel.textColor = UIColor.color_7f7f7f_565656
            mailImageView.setTintImageView(imageName: "ico_setting_contact",
                                                colorTint: UIColor.clear)
        case youtubeView:
            youtubeLabel.textColor = UIColor.color_7f7f7f_565656
            youtubeImageView.setTintImageView(imageName: "ico_youtube",
                                                     colorTint: UIColor.clear)
        default: break
        }
    }
    
    func unHighlight(view: HighlightView) {
        switch view {
        case phoneView:
            phoneLabel.textColor = UIColor.color_7f7f7f_565656
            phoneImageView.setTintImageView(imageName: "ico_phone",
                                              colorTint: UIColor.clear)
        case mailView:
            mailLabel.textColor = UIColor.color_7f7f7f_565656
            mailImageView.setTintImageView(imageName: "ico_setting_contact",
                                                colorTint: UIColor.clear)
        case youtubeView:
            youtubeLabel.textColor = UIColor.color_7f7f7f_565656
            youtubeImageView.setTintImageView(imageName: "ico_youtube",
                                                     colorTint: UIColor.clear)
        default: break
        }
    }
    
}
