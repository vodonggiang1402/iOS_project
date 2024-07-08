//
//  CountRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class CountRouter: PresenterToRouterCountProtocol {
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
        let storyboard = UIStoryboard(name: "CountStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:CountViewController.self)

        let presenter: ViewToPresenterCountProtocol & InteractorToPresenterCountProtocol = CountPresenter()
        let entity: InteractorToEntityCountProtocol = CountEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = CountRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CountInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

