//
//  SymbolDetailPresenter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation

class SymbolDetailPresenter: ViewToPresenterSymbolDetailProtocol {
    var currentIndexPath: IndexPath?
    var symbol: Symbol?
    
    var view: PresenterToViewSymbolDetailProtocol?
    var interactor: PresenterToInteractorSymbolDetailProtocol?
    var router: PresenterToRouterSymbolDetailProtocol?
    
}


extension SymbolDetailPresenter: InteractorToPresenterSymbolDetailProtocol {
    
}
