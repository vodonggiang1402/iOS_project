//
//  TutorialRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class TutorialRouter: PresenterToRouterTutorialProtocol {
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
        let storyboard = UIStoryboard(name: "TutorialStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:TutorialViewController.self)

        let presenter: ViewToPresenterTutorialProtocol & InteractorToPresenterTutorialProtocol = TutorialPresenter()
        let entity: InteractorToEntityTutorialProtocol = TutorialEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = TutorialRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TutorialInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

    func navigateToDetail(tutorial: Tutorial) {
        ListTutorialRouter().showScreen(tutorial: tutorial)
    }
}

