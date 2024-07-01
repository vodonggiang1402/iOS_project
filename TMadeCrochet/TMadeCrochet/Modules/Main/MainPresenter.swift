//
//  MainPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class MainPresenter: ViewToPresenterMainProtocol {
    
    var view: PresenterToViewMainProtocol?
    var interactor: PresenterToInteractorMainProtocol?
    var router: PresenterToRouterMainProtocol?
    
}


extension MainPresenter: InteractorToPresenterMainProtocol {
    
}
