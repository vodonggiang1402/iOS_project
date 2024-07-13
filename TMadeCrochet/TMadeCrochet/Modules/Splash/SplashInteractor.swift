//
//  SplashInteractor.swift
//  Probit
//
//  Created by Beacon on 21/08/2022.
//  
//

import Foundation

class SplashInteractor: PresenterToInteractorSplashProtocol {
    weak var presenter: InteractorToPresenterSplashProtocol?
    var entity: InteractorToEntitySplashProtocol?
    
    func getData() {
        DataManager.shared.readJSONFromFile(fileName: "symbols", type: SymbolResponseData.self) { result in
            AppConstant.symbolResponseData = result
            DataManager.shared.readJSONFromFile(fileName: "count", type: CountResponseData.self) { result in
                AppConstant.countResponseData = result
                self.presenter?.saveDataComplete()
            }
        }

    }
    
}
