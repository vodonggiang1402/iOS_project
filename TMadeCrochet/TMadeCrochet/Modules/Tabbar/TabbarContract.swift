//
//  TabbarContract.swift
//  Probit
//
//  Created by Giang Vo on 01/07/2024.
//
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewTabbarProtocol: AnyObject {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTabbarProtocol {
    var view: PresenterToViewTabbarProtocol? { get set }
    var interactor: PresenterToInteractorTabbarProtocol? { get set }
    var router: PresenterToRouterTabbarProtocol? { get set }
    
    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTabbarProtocol {
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTabbarProtocol: AnyObject {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTabbarProtocol {
    
}
