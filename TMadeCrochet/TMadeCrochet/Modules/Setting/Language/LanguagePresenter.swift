//
//  LanguagePresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class LanguagePresenter: ViewToPresenterLanguageProtocol {
  

    weak var view: PresenterToViewLanguageProtocol?
    var interactor: PresenterToInteractorLanguageProtocol?
    var router: PresenterToRouterLanguageProtocol?
    
    var languageAppSetting: [Language] {
        interactor?.languageAppSetting ?? []
    }
    
    deinit {
        self.view = nil
        self.interactor = nil
        self.router = nil
    }
    
    func getListLanguage() {
        interactor?.getData()
    }
    
    func changeLanguage(indexPath: IndexPath) {
        interactor?.changeLanguage(indexPath: indexPath)
    }
}


extension LanguagePresenter: InteractorToPresenterLanguageProtocol {
    func dataListDidFetch() {
        view?.reloadData()
    }
}
