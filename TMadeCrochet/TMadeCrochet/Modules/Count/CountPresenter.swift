//
//  CountPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class CountPresenter: ViewToPresenterCountProtocol {
    
    var view: PresenterToViewCountProtocol?
    var interactor: PresenterToInteractorCountProtocol?
    var router: PresenterToRouterCountProtocol?
    
}


extension CountPresenter: InteractorToPresenterCountProtocol {
    
}
