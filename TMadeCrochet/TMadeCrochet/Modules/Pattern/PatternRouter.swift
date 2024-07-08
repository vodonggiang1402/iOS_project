//
//  PatternRouter.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class PatternRouter: PresenterToRouterPatternProtocol {
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
        let storyboard = UIStoryboard(name: "PatternStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:PatternViewController.self)

        let presenter: ViewToPresenterPatternProtocol & InteractorToPresenterPatternProtocol = PatternPresenter()
        let entity: InteractorToEntityPatternProtocol = PatternEntity()
        viewController.presenter = presenter
        viewController.presenter?.router = PatternRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PatternInteractor()
        viewController.presenter?.interactor?.entity = entity

        return viewController
    }

}

