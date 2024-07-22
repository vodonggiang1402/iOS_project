//
//  PolicyPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class PolicyPresenter: ViewToPresenterPolicyProtocol {
    
    var view: PresenterToViewPolicyProtocol?
    var interactor: PresenterToInteractorPolicyProtocol?
    var router: PresenterToRouterPolicyProtocol?
    
}


extension PolicyPresenter: InteractorToPresenterPolicyProtocol {
    
}
