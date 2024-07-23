//
//  LanguageTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewLanguageProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLanguageProtocol {
    var view: PresenterToViewLanguageProtocol? { get set }
    var interactor: PresenterToInteractorLanguageProtocol? { get set }
    var router: PresenterToRouterLanguageProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLanguageProtocol {
    var entity: InteractorToEntityLanguageProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLanguageProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLanguageProtocol {

}

protocol InteractorToEntityLanguageProtocol {
    
}

