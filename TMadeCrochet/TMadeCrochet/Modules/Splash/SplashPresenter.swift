//
//  SplashPresenter.swift
//  Probit
//
//  Created by Beacon on 21/08/2022.
//  
//

import Foundation

class SplashPresenter: ViewToPresenterSplashProtocol {

    
    // MARK: Properties
    weak var view: PresenterToViewSplashProtocol?
    var interactor: PresenterToInteractorSplashProtocol?
    var router: PresenterToRouterSplashProtocol?
    
    deinit {
        self.view = nil
        self.interactor = nil
        self.router = nil
    }
    
    func navigateToRootMain() {
        self.router?.navigateToRootMain()
    }
    
}

extension SplashPresenter: InteractorToPresenterSplashProtocol {
    
}
