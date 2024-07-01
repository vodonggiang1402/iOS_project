//
//  KnittingRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class KnittingRouter: PresenterToRouterKnittingProtocol {
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
        let storyboard = UIStoryboard(name: "KnittingStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:KnittingViewController.self)

        let presenter: ViewToPresenterKnittingProtocol & InteractorToPresenterKnittingProtocol = KnittingPresenter()
        let entity: InteractorToEntityKnittingProtocol = KnittingEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = KnittingRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = KnittingInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

