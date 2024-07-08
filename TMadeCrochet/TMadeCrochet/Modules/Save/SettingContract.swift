//
//  SaveTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSaveProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSaveProtocol {
    var view: PresenterToViewSaveProtocol? { get set }
    var interactor: PresenterToInteractorSaveProtocol? { get set }
    var router: PresenterToRouterSaveProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSaveProtocol {
    var entity: InteractorToEntitySaveProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSaveProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSaveProtocol {

}

protocol InteractorToEntitySaveProtocol {
    
}

