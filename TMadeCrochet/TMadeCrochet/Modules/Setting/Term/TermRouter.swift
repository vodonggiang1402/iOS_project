//
//  TermRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class TermRouter: PresenterToRouterTermProtocol {
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
        let storyboard = UIStoryboard(name: "TermStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:TermViewController.self)

        let presenter: ViewToPresenterTermProtocol & InteractorToPresenterTermProtocol = TermPresenter()
        let entity: InteractorToEntityTermProtocol = TermEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = TermRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TermInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

