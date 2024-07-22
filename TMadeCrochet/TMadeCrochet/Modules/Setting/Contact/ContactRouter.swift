//
//  ContactRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class ContactRouter: PresenterToRouterContactProtocol {
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
        let storyboard = UIStoryboard(name: "ContactStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:ContactViewController.self)

        let presenter: ViewToPresenterContactProtocol & InteractorToPresenterContactProtocol = ContactPresenter()
        let entity: InteractorToEntityContactProtocol = ContactEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = ContactRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ContactInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

