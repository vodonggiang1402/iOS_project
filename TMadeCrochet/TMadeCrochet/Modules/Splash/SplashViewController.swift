//
//  SplashViewController.swift
//  Probit
//
//  Created by Beacon on 21/08/2022.
//  
//

import UIKit

class SplashViewController: BaseViewController { 
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    // MARK: - Properties
    var presenter: ViewToPresenterSplashProtocol?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar(isHide: true)
        self.loadingView.startAnimating()
        guard AppConstant.isFirstTime else {
            self.presenter?.getData()
            return
        }
        self.handleFlowApp()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func handleFlowApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.loadingView.stopAnimating()
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
