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

    func navigateToRootMain() {
        self.router?.navigateToRootMain()
    }
    
    func getData() {
        self.interactor?.getData()
    }
}

extension SplashPresenter: InteractorToPresenterSplashProtocol {
    func saveDataComplete() {
        view?.saveDataComplete()
    }
}
