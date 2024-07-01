//
//  ProfilePresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class ProfilePresenter: ViewToPresenterProfileProtocol {
    
    var view: PresenterToViewProfileProtocol?
    var interactor: PresenterToInteractorProfileProtocol?
    var router: PresenterToRouterProfileProtocol?
    
}


extension ProfilePresenter: InteractorToPresenterProfileProtocol {
    
}
