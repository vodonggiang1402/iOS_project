//
//  TabbarPresenter.swift
//  Probit
//
//  Created by Giang Vo on 01/07/2024.
//  
//

import Foundation

class TabbarPresenter: ViewToPresenterTabbarProtocol {

    // MARK: Properties
    weak var view: PresenterToViewTabbarProtocol?
    var interactor: PresenterToInteractorTabbarProtocol?
    var router: PresenterToRouterTabbarProtocol?
    
    func viewDidLoad() {
        
    }
}

extension TabbarPresenter: InteractorToPresenterTabbarProtocol {
    
}
