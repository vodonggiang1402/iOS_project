//
//  SymbolDetailRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class SymbolDetailRouter: PresenterToRouterSymbolDetailProtocol {
    func showScreen() {
        let destinationVC = self.createModule()
        destinationVC.hidesBottomBarWhenPushed = true
        UIViewController().getRootTabbarViewController().pushViewController(destinationVC, animated: true)
    }
    
    func showScreenAsModal() {
        let destinationVC = createModule()
        destinationVC.getRootTabbarViewController().topViewController?.modalPresentationStyle = .pageSheet
        destinationVC.getRootTabbarViewController().topViewController?.present(destinationVC, animated: true)
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
        let storyboard = UIStoryboard(name: "SymbolDetailStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:SymbolDetailViewController.self)

        let presenter: ViewToPresenterSymbolDetailProtocol & InteractorToPresenterSymbolDetailProtocol = SymbolDetailPresenter()
        let entity: InteractorToEntitySymbolDetailProtocol = SymbolDetailEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = SymbolDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SymbolDetailInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

