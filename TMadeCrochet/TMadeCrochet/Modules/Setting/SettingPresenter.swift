//
//  SavePresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class SavePresenter: ViewToPresenterSaveProtocol {
    
    var view: PresenterToViewSaveProtocol?
    var interactor: PresenterToInteractorSaveProtocol?
    var router: PresenterToRouterSaveProtocol?
    
}


extension SavePresenter: InteractorToPresenterSaveProtocol {
    
}
