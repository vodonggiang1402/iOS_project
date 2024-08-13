//
//  SymbolDetailRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class SymbolDetailRouter: PresenterToRouterSymbolDetailProtocol {
    func showScreen(symbol: Symbol, currentIndexPath: IndexPath) {
        let destinationVC = self.createModule(symbol: symbol, currentIndexPath: currentIndexPath)
        destinationVC.hidesBottomBarWhenPushed = true
        UIViewController().getRootTabbarViewController().pushViewController(destinationVC, animated: true)
    }
    
    func showScreenAsModal(symbol: Symbol, currentIndexPath: IndexPath) {
        let destinationVC = createModule(symbol: symbol, currentIndexPath: currentIndexPath)
        destinationVC.getRootTabbarViewController().topViewController?.modalPresentationStyle = .pageSheet
        destinationVC.getRootTabbarViewController().topViewController?.present(destinationVC, animated: true)
    }

    func setupRootView(symbol: Symbol, currentIndexPath: IndexPath) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appdelegate.window else { return }

        let destinationVC = self.createModule(symbol: symbol, currentIndexPath: currentIndexPath)
        window.rootViewController = UINavigationController.init(rootViewController: destinationVC)
        window.makeKeyAndVisible()
    }

    // MARK: Static methods
    func createModule(symbol: Symbol, currentIndexPath: IndexPath) -> UIViewController {
        let storyboard = UIStoryboard(name: "SymbolDetailStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:SymbolDetailViewController.self)

        let presenter: ViewToPresenterSymbolDetailProtocol & InteractorToPresenterSymbolDetailProtocol = SymbolDetailPresenter()
        let entity: InteractorToEntitySymbolDetailProtocol = SymbolDetailEntity()
        viewController.presenter = presenter
        viewController.presenter?.symbol = symbol
        viewController.presenter?.currentIndexPath = currentIndexPath
        viewController.presenter?.router = SymbolDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SymbolDetailInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

