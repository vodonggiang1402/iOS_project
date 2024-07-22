//
//  ContactTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewContactProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterContactProtocol {
    var view: PresenterToViewContactProtocol? { get set }
    var interactor: PresenterToInteractorContactProtocol? { get set }
    var router: PresenterToRouterContactProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorContactProtocol {
    var entity: InteractorToEntityContactProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterContactProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterContactProtocol {

}

protocol InteractorToEntityContactProtocol {
    
}

