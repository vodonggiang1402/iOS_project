//
//  PolicyTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewPolicyProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPolicyProtocol {
    var view: PresenterToViewPolicyProtocol? { get set }
    var interactor: PresenterToInteractorPolicyProtocol? { get set }
    var router: PresenterToRouterPolicyProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPolicyProtocol {
    var entity: InteractorToEntityPolicyProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPolicyProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPolicyProtocol {

}

protocol InteractorToEntityPolicyProtocol {
    
}

