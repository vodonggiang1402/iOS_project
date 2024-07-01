//
//  ProfileTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewProfileProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterProfileProtocol {
    var view: PresenterToViewProfileProtocol? { get set }
    var interactor: PresenterToInteractorProfileProtocol? { get set }
    var router: PresenterToRouterProfileProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorProfileProtocol {
    var entity: InteractorToEntityProfileProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterProfileProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterProfileProtocol {

}

protocol InteractorToEntityProfileProtocol {
    
}

