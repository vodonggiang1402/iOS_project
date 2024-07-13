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
    func saveDataComplete()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSplashProtocol {
    var view: PresenterToViewSplashProtocol? { get set }
    var interactor: PresenterToInteractorSplashProtocol? { get set }
    var router: PresenterToRouterSplashProtocol? { get set }
    func navigateToRootMain()
    func getData()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSplashProtocol {
    var presenter: InteractorToPresenterSplashProtocol? { get set }
    var entity: InteractorToEntitySplashProtocol? { get set }
    func getData()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSplashProtocol: AnyObject {
    func saveDataComplete()
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSplashProtocol {
    func navigateToRootMain()
}

protocol InteractorToEntitySplashProtocol {
    
}
