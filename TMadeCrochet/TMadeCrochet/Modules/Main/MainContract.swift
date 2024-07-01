//
//  MainTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewMainProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainProtocol {
    var view: PresenterToViewMainProtocol? { get set }
    var interactor: PresenterToInteractorMainProtocol? { get set }
    var router: PresenterToRouterMainProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainProtocol {
    var entity: InteractorToEntityMainProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainProtocol {

}

protocol InteractorToEntityMainProtocol {
    
}

