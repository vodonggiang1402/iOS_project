//
//  ProfileRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class ProfileRouter: PresenterToRouterProfileProtocol {
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
        let storyboard = UIStoryboard(name: "ProfileStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:ProfileViewController.self)

        let presenter: ViewToPresenterProfileProtocol & InteractorToPresenterProfileProtocol = ProfilePresenter()
        let entity: InteractorToEntityProfileProtocol = ProfileEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = ProfileRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ProfileInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

