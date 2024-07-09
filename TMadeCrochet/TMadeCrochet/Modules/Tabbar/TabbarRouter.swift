//
//  TabbarRouter.swift
//  Probit
//
//  Created by Giang Vo on 01/07/2024.
//  
//

import Foundation
import UIKit

class TabbarRouter: PresenterToRouterTabbarProtocol {
    func showScreen() {
        let destinationVC = self.createModule()
        destinationVC.getRootViewController().navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func setupRootView() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appdelegate.window else { return }
        
        let destinationVC = self.createModule()
        window.rootViewController = destinationVC
        window.makeKeyAndVisible()
        AppDelegate.shared.tabbarViewController = destinationVC as? TabbarViewController
    }
    
    // MARK: Static methods
    func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let viewController = storyboard.instantiateViewController(viewControllerType:TabbarViewController.self)
        
        let presenter: ViewToPresenterTabbarProtocol & InteractorToPresenterTabbarProtocol = TabbarPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = TabbarRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TabbarInteractor()
        viewController.setupTabbarItems(items: [.count, .symbol, .pattern, .setting])
        return viewController
    }
    
}
