//
//  SymbolTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSymbolProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSymbolProtocol {
    var view: PresenterToViewSymbolProtocol? { get set }
    var interactor: PresenterToInteractorSymbolProtocol? { get set }
    var router: PresenterToRouterSymbolProtocol? { get set }
    func navigateToDetail()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSymbolProtocol {
    var entity: InteractorToEntitySymbolProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSymbolProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSymbolProtocol {
    func navigateToDetail()
}

protocol InteractorToEntitySymbolProtocol {
    
}

