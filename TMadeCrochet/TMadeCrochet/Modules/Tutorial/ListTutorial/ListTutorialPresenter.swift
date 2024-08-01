//
//  ListTutorialPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class ListTutorialPresenter: ViewToPresenterListTutorialProtocol {
    var tutorial: Tutorial?
    
    var view: PresenterToViewListTutorialProtocol?
    var interactor: PresenterToInteractorListTutorialProtocol?
    var router: PresenterToRouterListTutorialProtocol?
    
}


extension ListTutorialPresenter: InteractorToPresenterListTutorialProtocol {
    
}
