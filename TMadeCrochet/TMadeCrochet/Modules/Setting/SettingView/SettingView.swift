//
//  SettingView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 22/7/24.
//

import Foundation
import UIKit

protocol SettingViewDelegate: AnyObject {
    func languageViewNormalTap()
    func termViewNormalTap()
    func policyViewNormalTap()
    func contactViewNormalTap()
    func shareViewNormalTap()
    func rateViewNormalTap()
}

class SettingView: BaseView {
    @IBOutlet weak var languageView: HighlightView!
    @IBOutlet weak var termView: HighlightView!
    @IBOutlet weak var policyView: HighlightView!
    @IBOutlet weak var contactView: HighlightView!
    @IBOutlet weak var shareView: HighlightView!
    @IBOutlet weak var rateView: HighlightView!
    @IBOutlet weak var versionView: HighlightView!

    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var termLabel: UILabel!
    @IBOutlet private weak var policyLabel: UILabel!
    @IBOutlet private weak var contactLabel: UILabel!
    @IBOutlet private weak var shareLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!
        
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var termImageView: UIImageView!
    @IBOutlet weak var policyImageView: UIImageView!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var rateImage: UIImageView!
    @IBOutlet weak var vesionImage: UIImageView!
    
    weak var delegate: SettingViewDelegate?
    
    override func localizedString() { 
        languageLabel.text = "language_text".Localizable()
        termLabel.text = "term_text".Localizable()
        policyLabel.text = "policy_text".Localizable()
        contactLabel.text = "contact_text".Localizable()
        shareLabel.text = "share_text".Localizable()
        rateLabel.text = "rate_text".Localizable()
        versionLabel.text = String.init(format:"%@: %@", "app_version".Localizable(), AppConstant.appVersion)
    }
    
    override func setupUI() {
        
        languageImageView.layer.cornerRadius = 5
        languageImageView.layer.masksToBounds = true
        
        termImageView.layer.cornerRadius = 5
        termImageView.layer.masksToBounds = true
        
        policyImageView.layer.cornerRadius = 5
        policyImageView.layer.masksToBounds = true
        
        contactImageView.layer.cornerRadius = 5
        contactImageView.layer.masksToBounds = true
        
        shareImageView.layer.cornerRadius = 5
        shareImageView.layer.masksToBounds = true
        
        rateImage.layer.cornerRadius = 5
        rateImage.layer.masksToBounds = true
        
        languageView.delegate = self
        languageView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.languageViewNormalTap()
        }
        
        termView.delegate = self
        termView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.termViewNormalTap()
        }
        
        policyView.delegate = self
        policyView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.policyViewNormalTap()
        }
        
        contactView.delegate = self
        contactView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.contactViewNormalTap()
        }
        
        shareView.delegate = self
        shareView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.shareViewNormalTap()
        }
        
        rateView.delegate = self
        rateView.addTapGesture { [weak self] in
            guard let self = self else { return }
            self.delegate?.rateViewNormalTap()
        }
        
    }
    
}

extension SettingView: HighlightViewProtocol {
    func highlight(view: HighlightView) {
        switch view {
        case languageView:
            languageLabel.textColor = UIColor.color_7f7f7f_565656
            languageImageView.setTintImageView(imageName: "ico_setting_language",
                                              colorTint: UIColor.color_fafafa_1818181)
        case termView:
            termLabel.textColor = UIColor.color_7f7f7f_565656
            termImageView.setTintImageView(imageName: "ico_setting_term",
                                                colorTint: UIColor.color_fafafa_1818181)
        case policyView:
            policyLabel.textColor = UIColor.color_7f7f7f_565656
            policyImageView.setTintImageView(imageName: "ico_setting_policy",
                                                     colorTint: UIColor.color_fafafa_1818181)
        case contactView:
            contactLabel.textColor = UIColor.color_7f7f7f_565656
            contactImageView.setTintImageView(imageName: "ico_setting_contact",
                                                   colorTint: UIColor.color_fafafa_1818181)
        case shareView:
            shareLabel.textColor = UIColor.color_7f7f7f_565656
            shareImageView.setTintImageView(imageName: "ico_setting_share",
                                               colorTint: UIColor.color_fafafa_1818181)
        case rateView:
            rateLabel.textColor = UIColor.color_7f7f7f_565656
            rateImage.setTintImageView(imageName: "ico_setting_rate",
                                               colorTint: UIColor.color_fafafa_1818181)
        default: break
        }
    }
    
    func unHighlight(view: HighlightView) {
        switch view {
        case languageView:
            languageLabel.textColor = UIColor.color_7f7f7f_565656
            languageImageView.image = UIImage(named: "ico_setting_language")
        case termView:
            termLabel.textColor = UIColor.color_7f7f7f_565656
            termImageView.image = UIImage(named: "ico_setting_term")
        case policyView:
            policyLabel.textColor = UIColor.color_7f7f7f_565656
            policyImageView.image = UIImage(named: "ico_setting_policy")
        case contactView:
            contactLabel.textColor = UIColor.color_7f7f7f_565656
            contactImageView.image = UIImage(named: "ico_setting_contact")
        case shareView:
            shareLabel.textColor = UIColor.color_7f7f7f_565656
            shareImageView.image = UIImage(named: "ico_setting_share")
        case rateView:
            rateLabel.textColor = UIColor.color_7f7f7f_565656
            rateImage.image = UIImage(named: "ico_setting_rate")
        default: break
        }
    }
    
}
