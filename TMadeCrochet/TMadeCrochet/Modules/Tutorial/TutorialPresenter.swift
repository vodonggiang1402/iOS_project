//
//  TutorialPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class TutorialPresenter: ViewToPresenterTutorialProtocol {
    
    var view: PresenterToViewTutorialProtocol?
    var interactor: PresenterToInteractorTutorialProtocol?
    var router: PresenterToRouterTutorialProtocol?
    
}


extension TutorialPresenter: InteractorToPresenterTutorialProtocol {
    
}
