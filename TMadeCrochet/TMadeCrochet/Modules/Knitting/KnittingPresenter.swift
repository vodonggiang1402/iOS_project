//
//  KnittingPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class KnittingPresenter: ViewToPresenterKnittingProtocol {
    
    var view: PresenterToViewKnittingProtocol?
    var interactor: PresenterToInteractorKnittingProtocol?
    var router: PresenterToRouterKnittingProtocol?
    
}


extension KnittingPresenter: InteractorToPresenterKnittingProtocol {
    
}
