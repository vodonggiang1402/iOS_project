//
//  ListTutorialRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class ListTutorialRouter: PresenterToRouterListTutorialProtocol {
    func showScreen(tutorial: Tutorial) {
        let destinationVC = self.createModule(tutorial: tutorial)
        destinationVC.hidesBottomBarWhenPushed = true
        UIViewController().getRootTabbarViewController().pushViewController(destinationVC, animated: true)
    }

    func setupRootView(tutorial: Tutorial) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appdelegate.window else { return }

        let destinationVC = self.createModule(tutorial: tutorial)
        window.rootViewController = UINavigationController.init(rootViewController: destinationVC)
        window.makeKeyAndVisible()
    }

    // MARK: Static methods
    func createModule(tutorial: Tutorial) -> UIViewController {
        let storyboard = UIStoryboard(name: "ListTutorialStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:ListTutorialViewController.self)

        let presenter: ViewToPresenterListTutorialProtocol & InteractorToPresenterListTutorialProtocol = ListTutorialPresenter()
        let entity: InteractorToEntityListTutorialProtocol = ListTutorialEntity()
        viewController.presenter = presenter
        viewController.presenter?.tutorial = tutorial
        viewController.presenter?.router = ListTutorialRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ListTutorialInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

