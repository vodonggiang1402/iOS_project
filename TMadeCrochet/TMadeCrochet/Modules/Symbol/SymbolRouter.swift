//
//  SymbolRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class SymbolRouter: PresenterToRouterSymbolProtocol {
    func showScreen() {
        let destinationVC = self.createModule()
        destinationVC.hidesBottomBarWhenPushed = true
        UIViewController().getRootTabbarViewController().pushViewController(destinationVC, animated: true)
    }

    func setupRootView() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appdelegate.window else { return }

        let destinationVC = self.createModule()
        window.rootViewController = UINavigationController.init(rootViewController: destinationVC)
        window.makeKeyAndVisible()
    }

    // MARK: Static methods
    func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "SymbolStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:SymbolViewController.self)

        let presenter: ViewToPresenterSymbolProtocol & InteractorToPresenterSymbolProtocol = SymbolPresenter()
        let entity: InteractorToEntitySymbolProtocol = SymbolEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = SymbolRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SymbolInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

    func navigateToDetail(symbol: Symbol, currentIndexPath: IndexPath) {
        SymbolDetailRouter().showScreen(symbol: symbol, currentIndexPath: currentIndexPath)
    }
}

