//
//  SaveRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class SaveRouter: PresenterToRouterSaveProtocol {
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
        let storyboard = UIStoryboard(name: "SaveStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:SaveViewController.self)

        let presenter: ViewToPresenterSaveProtocol & InteractorToPresenterSaveProtocol = SavePresenter()
        let entity: InteractorToEntitySaveProtocol = SaveEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = SaveRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SaveInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

