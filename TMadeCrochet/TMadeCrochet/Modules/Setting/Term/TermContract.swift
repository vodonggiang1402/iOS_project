//
//  TermTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewTermProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTermProtocol {
    var view: PresenterToViewTermProtocol? { get set }
    var interactor: PresenterToInteractorTermProtocol? { get set }
    var router: PresenterToRouterTermProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTermProtocol {
    var entity: InteractorToEntityTermProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTermProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTermProtocol {

}

protocol InteractorToEntityTermProtocol {
    
}

