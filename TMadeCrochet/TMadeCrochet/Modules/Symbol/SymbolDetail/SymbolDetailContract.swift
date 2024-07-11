//
//  SymbolDetailTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSymbolDetailProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSymbolDetailProtocol {
    var view: PresenterToViewSymbolDetailProtocol? { get set }
    var interactor: PresenterToInteractorSymbolDetailProtocol? { get set }
    var router: PresenterToRouterSymbolDetailProtocol? { get set }
    
    var symbol: Symbol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSymbolDetailProtocol {
    var entity: InteractorToEntitySymbolDetailProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSymbolDetailProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSymbolDetailProtocol {

}

protocol InteractorToEntitySymbolDetailProtocol {
    
}

