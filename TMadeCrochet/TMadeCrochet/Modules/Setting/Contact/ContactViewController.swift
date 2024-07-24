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
        showMailComposer()
    }
    
    func showMailComposer() {
         guard MFMailComposeViewController.canSendMail() else{
           return
         }
         let composer = MFMailComposeViewController()
         composer.mailComposeDelegate = self
        composer.setToRecipients([AppConstant.mailContact])
         composer.setSubject("Diabell App Help")
         composer.setMessageBody("Fyll i vad du behöver hjälp med", isHTML: false)
         present(composer, animated: true)
     }
    
    func youtubeViewNormalTap() {
        
    }
}
