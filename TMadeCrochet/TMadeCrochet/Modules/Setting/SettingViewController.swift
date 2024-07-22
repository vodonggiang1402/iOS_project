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
        self.setupNavigationBar(title: "Cài đặt", isShowLeft: false)
        self.setupUISetting()
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
    
    func setupUISetting() {
        settingView.delegate = self
    }
}
    

extension SettingViewController: PresenterToViewSettingProtocol {
    
}

// MARK: - SettingViewDelegate
extension SettingViewController: SettingViewDelegate {
    func termViewNormalTap() {
        
    }
    
    func policyViewNormalTap() {
        
    }
    
    func contactViewNormalTap() {
        
    }
    
    func shareViewNormalTap() {
        
    }
    
    func rateViewNormalTap() {
        
    }
    
    
}
