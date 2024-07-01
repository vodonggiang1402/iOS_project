//
//  KnittingTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewKnittingProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterKnittingProtocol {
    var view: PresenterToViewKnittingProtocol? { get set }
    var interactor: PresenterToInteractorKnittingProtocol? { get set }
    var router: PresenterToRouterKnittingProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorKnittingProtocol {
    var entity: InteractorToEntityKnittingProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterKnittingProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterKnittingProtocol {

}

protocol InteractorToEntityKnittingProtocol {
    
}

