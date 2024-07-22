//
//  TermPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class TermPresenter: ViewToPresenterTermProtocol {
    
    var view: PresenterToViewTermProtocol?
    var interactor: PresenterToInteractorTermProtocol?
    var router: PresenterToRouterTermProtocol?
    
}


extension TermPresenter: InteractorToPresenterTermProtocol {
    
}
