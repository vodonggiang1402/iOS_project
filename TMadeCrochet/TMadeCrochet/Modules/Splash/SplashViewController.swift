//
//  SplashViewController.swift
//  Probit
//
//  Created by Beacon on 21/08/2022.
//  
//

import UIKit

class SplashViewController: BaseViewController { 
    
    // MARK: - Properties
    var presenter: ViewToPresenterSplashProtocol?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar(isHide: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        guard AppConstant.isFirstTime else {
//            self.presenter?.getData()
//            return
//        }
        self.presenter?.getData()
        self.handleFlowApp()
    }
    
    func handleFlowApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            AppConstant.isFirstTime = true
            self.presenter?.navigateToRootMain()
        }
    }
}

extension SplashViewController: PresenterToViewSplashProtocol{
    func saveDataComplete() {
        self.handleFlowApp()
    }
}
