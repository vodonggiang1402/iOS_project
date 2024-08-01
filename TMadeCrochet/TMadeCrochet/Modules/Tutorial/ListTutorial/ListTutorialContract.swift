//
//  ListTutorialTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewListTutorialProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterListTutorialProtocol {
    var view: PresenterToViewListTutorialProtocol? { get set }
    var interactor: PresenterToInteractorListTutorialProtocol? { get set }
    var router: PresenterToRouterListTutorialProtocol? { get set }
    
    var tutorial: Tutorial? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorListTutorialProtocol {
    var entity: InteractorToEntityListTutorialProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterListTutorialProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterListTutorialProtocol {

}

protocol InteractorToEntityListTutorialProtocol {
    
}

