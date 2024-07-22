//
//  ContactPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class ContactPresenter: ViewToPresenterContactProtocol {
    
    var view: PresenterToViewContactProtocol?
    var interactor: PresenterToInteractorContactProtocol?
    var router: PresenterToRouterContactProtocol?
    
}


extension ContactPresenter: InteractorToPresenterContactProtocol {
    
}
