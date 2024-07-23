//
//  LanguageRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class LanguageRouter: PresenterToRouterLanguageProtocol {
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
        let storyboard = UIStoryboard(name: "LanguageStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:LanguageViewController.self)

        let presenter: ViewToPresenterLanguageProtocol & InteractorToPresenterLanguageProtocol = LanguagePresenter()
        let entity: InteractorToEntityLanguageProtocol = LanguageEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = LanguageRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LanguageInteractor()
        viewController.presenter?.interactor?.entity = entity
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
    }

}

