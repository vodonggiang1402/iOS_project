//
//  LanguageTfaContract.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewLanguageProtocol: AnyObject {
    func reloadData()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLanguageProtocol {
    var view: PresenterToViewLanguageProtocol? { get set }
    var interactor: PresenterToInteractorLanguageProtocol? { get set }
    var router: PresenterToRouterLanguageProtocol? { get set }
    
    var languageAppSetting: [Language] { get }
    func getListLanguage()
    func changeLanguage(indexPath: IndexPath)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLanguageProtocol {
    var entity: InteractorToEntityLanguageProtocol? { get set }
    var presenter: InteractorToPresenterLanguageProtocol? { get set }
    
    var languageAppSetting: [Language] { get set }
    func getData()
    func changeLanguage(indexPath: IndexPath)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLanguageProtocol {
    func dataListDidFetch()
    
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLanguageProtocol {

}

protocol InteractorToEntityLanguageProtocol {
    
}

