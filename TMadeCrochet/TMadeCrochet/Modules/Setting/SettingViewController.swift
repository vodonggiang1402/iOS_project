//
//  SettingViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class SettingViewController: BaseViewController {
    var presenter: ViewToPresenterSettingProtocol?
    
    @IBOutlet weak var settingView: SettingView!
    
    deinit {
        settingView?.delegate = nil
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "setting_screen_header_title".Localizable(), isShowLeft: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUISetting()
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
    
    func setupUISetting() {
        settingView.delegate = self
    }
}
    

extension SettingViewController: PresenterToViewSettingProtocol {
    
}

// MARK: - SettingViewDelegate
extension SettingViewController: SettingViewDelegate {
    func languageViewNormalTap() {
        self.presenter?.navigateToLaguage()
    }
    
    func termViewNormalTap() {
        self.presenter?.navigateToTerm()
    }
    
    func policyViewNormalTap() {
        self.presenter?.navigateToPolicy()
    }
    
    func contactViewNormalTap() {
        self.presenter?.navigateToContact()
    }
    
    func shareViewNormalTap() {
        shareApp()
    }
    
    func rateViewNormalTap() {
        
    }
    
    func shareApp() {
        // Setting description
        let firstActivityItem = "share_app_info".Localizable()

          // Setting url
        let secondActivityItem : NSURL = NSURL(string: AppConstant.tmadeAppLink)!
          
          // If you want to use an image
          let activityViewController : UIActivityViewController = UIActivityViewController(
              activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
          
          // This line remove the arrow of the popover to show in iPad
          activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
          activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
          
          // Pre-configuring activity items
          activityViewController.activityItemsConfiguration = [
          UIActivity.ActivityType.message
          ] as? UIActivityItemsConfigurationReading
          
          // Anything you want to exclude
          activityViewController.excludedActivityTypes = [
              UIActivity.ActivityType.postToWeibo,
              UIActivity.ActivityType.print,
              UIActivity.ActivityType.assignToContact,
              UIActivity.ActivityType.saveToCameraRoll,
              UIActivity.ActivityType.addToReadingList,
              UIActivity.ActivityType.postToFlickr,
              UIActivity.ActivityType.postToVimeo,
              UIActivity.ActivityType.postToTencentWeibo,
              UIActivity.ActivityType.postToFacebook
          ]
          
          activityViewController.isModalInPresentation = true
          self.present(activityViewController, animated: true, completion: nil)
    }
}
