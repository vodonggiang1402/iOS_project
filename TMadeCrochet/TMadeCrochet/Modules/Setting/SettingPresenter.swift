//
//  SettingPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class SettingPresenter: ViewToPresenterSettingProtocol {
    
    var view: PresenterToViewSettingProtocol?
    var interactor: PresenterToInteractorSettingProtocol?
    var router: PresenterToRouterSettingProtocol?
    
    func navigateToTerm() {
        self.router?.navigateToTerm()
    }
    
    func navigateToPolicy() {
        self.router?.navigateToPolicy()
    }
    
    func navigateToContact() {
        self.router?.navigateToContact()
    }
}


extension SettingPresenter: InteractorToPresenterSettingProtocol {
    
}
