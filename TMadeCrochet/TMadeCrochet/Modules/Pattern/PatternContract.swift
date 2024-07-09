//
//  PatternTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewPatternProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPatternProtocol {
    var view: PresenterToViewPatternProtocol? { get set }
    var interactor: PresenterToInteractorPatternProtocol? { get set }
    var router: PresenterToRouterPatternProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPatternProtocol {
    var entity: InteractorToEntityPatternProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPatternProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPatternProtocol {

}

protocol InteractorToEntityPatternProtocol {
    
}

