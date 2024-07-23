//
//  LanguagePresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class LanguagePresenter: ViewToPresenterLanguageProtocol {
    
    var view: PresenterToViewLanguageProtocol?
    var interactor: PresenterToInteractorLanguageProtocol?
    var router: PresenterToRouterLanguageProtocol?
    
}


extension LanguagePresenter: InteractorToPresenterLanguageProtocol {
    
}
