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
    
}


extension SettingPresenter: InteractorToPresenterSettingProtocol {
    
}
