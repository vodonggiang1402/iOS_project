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
    }
    
    deinit {
        self.presenter = nil
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.handleFlowApp()
        }
    }
    
    func handleFlowApp() {
//        self.presenter?.navigateToRootHome()
        TabbarRouter().setupRootView()
    }
}

extension SplashViewController: PresenterToViewSplashProtocol{
    // TODO: Implement View Output Methods
}
