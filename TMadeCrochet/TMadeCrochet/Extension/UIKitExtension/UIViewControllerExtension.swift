//
//  UIViewControllerExtension.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 1/7/24.
//

import Foundation

import UIKit

extension UIViewController {
    // MARK: - Handle Root View
    func getRootViewController() -> UIViewController {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return BaseViewController()
        }
        
        if  let rootVC = appDelegate.window?.rootViewController as? BaseViewController {
            return rootVC
        }
        if let rootNav = appDelegate.window?.rootViewController as? UINavigationController,
            let firstVC = rootNav.viewControllers.first as? BaseViewController {
            return firstVC
        }
        return BaseViewController()
    }
    
    func isVisible() -> Bool {
        return self.viewIfLoaded?.window != nil
    }
    
    func getRootTabbarViewController() -> UINavigationController {
        let defaultController = UINavigationController(rootViewController: getRootViewController())
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window,
              let rootController = window.rootViewController as? TabbarViewController else {
            return defaultController
        }
        let selectedIndex = rootController.selectedIndex
        
        guard let currentController = rootController.viewControllers?[selectedIndex] as? UINavigationController else {
            return defaultController
        }
        return currentController
    }
    
    func setupSelectedIndex(index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window,
              let rootController = window.rootViewController as? TabbarViewController else { return }
        rootController.selectedIndex = index
    }
    
    func getLastViewControllerInNav() -> UIViewController {
        let rootViewController = self.getRootViewController()
        return rootViewController.navigationController?.viewControllers.last ?? BaseViewController()
    }
    
    // MARK: - Translation ViewController
    func pushTo<T: UIViewController>(desVC: T.Type, from storyboard: UIStoryboard = UIStoryboard.Splash, animated: Bool = true) -> T {
        let viewController = storyboard.instantiateViewController(viewControllerType: desVC.self)
        getRootViewController().navigationController?.pushViewController(viewController, animated: animated)
        return viewController
    }
    
    func pop(isAnimated: Bool = true) {
        self.navigationController?.popViewController(animated: isAnimated)
    }
    
    func popToViewController(index: Int = 0, animation: Bool = false) {
        guard let desVC = self.navigationController?.viewControllers[index] else { return }
        self.navigationController?.popToViewController(desVC, animated: animation)
    }
    
    func popToViewController(className: String, animation: Bool = false) {
        guard let listVC = self.navigationController?.viewControllers else { return }
        for i in 0..<listVC.count {
            if let vc = self.navigationController?.viewControllers[i],
               vc.className == className {
                self.navigationController?.popToViewController(vc, animated: animation)
                return
            }
        }
    }
}

extension UIApplication {
    
    func getTopViewController(base: UIViewController? = UIApplication.shared.mainKeyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    var mainKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }
}
