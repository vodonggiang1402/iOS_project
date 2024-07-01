//
//  SplashContract.swift
//  Probit
//
//  Created by Beacon on 21/08/2022.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSplashProtocol: AnyObject {
   
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSplashProtocol {
    var view: PresenterToViewSplashProtocol? { get set }
    var interactor: PresenterToInteractorSplashProtocol? { get set }
    var router: PresenterToRouterSplashProtocol? { get set }
    func navigateToRootHome()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSplashProtocol {
    var entity: InteractorToEntitySplashProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSplashProtocol: AnyObject {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSplashProtocol {
    func navigateToRootHome()
}

protocol InteractorToEntitySplashProtocol {
}
