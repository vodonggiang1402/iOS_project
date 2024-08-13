//
//  SymbolPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class SymbolPresenter: ViewToPresenterSymbolProtocol {
    var view: PresenterToViewSymbolProtocol?
    var interactor: PresenterToInteractorSymbolProtocol?
    var router: PresenterToRouterSymbolProtocol?
    
    func navigateToDetail(symbol: Symbol, currentIndexPath: IndexPath) {
        self.router?.navigateToDetail(symbol: symbol, currentIndexPath: currentIndexPath)
    }
}


extension SymbolPresenter: InteractorToPresenterSymbolProtocol {
    
}
