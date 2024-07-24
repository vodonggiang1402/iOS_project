//
//  TutorialTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewTutorialProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTutorialProtocol {
    var view: PresenterToViewTutorialProtocol? { get set }
    var interactor: PresenterToInteractorTutorialProtocol? { get set }
    var router: PresenterToRouterTutorialProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTutorialProtocol {
    var entity: InteractorToEntityTutorialProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTutorialProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTutorialProtocol {

}

protocol InteractorToEntityTutorialProtocol {
    
}

