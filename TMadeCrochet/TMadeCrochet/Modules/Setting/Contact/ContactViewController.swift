//
//  ContactViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit
import MessageUI

class ContactViewController: BaseViewController, MFMailComposeViewControllerDelegate {
    var presenter: ViewToPresenterContactProtocol?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contactView: ContactView!
    
    deinit {
        contactView?.delegate = nil
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "contact_screen_header_title".Localizable(), isShowLeft: true)
        self.titleLabel.text = "contact_screent_title_text".Localizable()
        self.contactView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

}
    

extension ContactViewController: PresenterToViewContactProtocol {
    
}

// MARK: - SettingViewDelegate
extension ContactViewController: ContactViewDelegate {
    func phoneViewNormalTap() {
        let phoneNumber = AppConstant.phoneContact
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func mailViewNormalTap() {
        let appURL = URL(string: "mailto:tmadeapp@gmail.com")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appURL)
        }
    }
    
    func youtubeViewNormalTap() {
        let youtubeContact =  AppConstant.youtubeContact
        let appURL = NSURL(string: "youtube://www.youtube.com/@\(youtubeContact)")!
        let webURL = NSURL(string: "https://www.youtube.com/@\(youtubeContact)")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL as URL) {
           application.open(appURL as URL)
        } else {
           // if Youtube app is not installed, open URL inside Safari
           application.open(webURL as URL)
        }
    }
}
