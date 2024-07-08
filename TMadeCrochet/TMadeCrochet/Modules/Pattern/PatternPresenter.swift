//
//  PatternPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class PatternPresenter: ViewToPresenterPatternProtocol {
    
    var view: PresenterToViewPatternProtocol?
    var interactor: PresenterToInteractorPatternProtocol?
    var router: PresenterToRouterPatternProtocol?
    
}


extension PatternPresenter: InteractorToPresenterPatternProtocol {
    
}
