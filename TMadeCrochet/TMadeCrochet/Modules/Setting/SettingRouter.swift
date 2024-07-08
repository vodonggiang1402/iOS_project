//
//  SettingRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class SettingRouter: PresenterToRouterSettingProtocol {
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
        let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:SettingViewController.self)

        let presenter: ViewToPresenterSettingProtocol & InteractorToPresenterSettingProtocol = SettingPresenter()
        let entity: InteractorToEntitySettingProtocol = SettingEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = SettingRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SettingInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

