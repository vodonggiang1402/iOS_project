//
//  CountTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewCountProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCountProtocol {
    var view: PresenterToViewCountProtocol? { get set }
    var interactor: PresenterToInteractorCountProtocol? { get set }
    var router: PresenterToRouterCountProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCountProtocol {
    var entity: InteractorToEntityCountProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCountProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCountProtocol {

}

protocol InteractorToEntityCountProtocol {
    
}

