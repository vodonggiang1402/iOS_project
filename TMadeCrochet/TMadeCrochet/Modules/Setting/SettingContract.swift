//
//  SettingTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSettingProtocol: AnyObject {

}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSettingProtocol {
    var view: PresenterToViewSettingProtocol? { get set }
    var interactor: PresenterToInteractorSettingProtocol? { get set }
    var router: PresenterToRouterSettingProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSettingProtocol {
    var entity: InteractorToEntitySettingProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSettingProtocol {

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSettingProtocol {

}

protocol InteractorToEntitySettingProtocol {
    
}

