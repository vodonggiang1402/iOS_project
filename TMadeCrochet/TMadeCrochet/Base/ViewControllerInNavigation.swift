//
//  ViewControllerInNavigation.swift
//  Probit
//
//  Created by Vo Dong Giang on 10/05/2023.
//

import Foundation
import UIKit

protocol ViewControllerInNavigation {

    var numberViewController: Int? { get }

    func delegateSwipeBack(of viewController: UIViewController?, to delegate: UIViewController?)

    func enableSwipeBack(enable: Bool, for viewController: UIViewController?)

    func viewWillSwipeBack()
}

extension ViewControllerInNavigation where Self: UIViewController {

    var numberViewController: Int? {
        return self.navigationController?.viewControllers.count
    }

    func delegateSwipeBack(of viewController: UIViewController?, to delegate: UIViewController?) {
        viewController?.navigationController?.interactivePopGestureRecognizer?.delegate = delegate
    }

    func enableSwipeBack(enable: Bool, for viewController: UIViewController?) {
        viewController?.navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            (self as? ViewControllerInNavigation)?.viewWillSwipeBack()
        }
        return true
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
          if let topViewController = UIApplication.shared.getTopViewController(),
                self.hasNotAcceptSwipeBackGesture(topViewController: topViewController)
          {
              (self as? ViewControllerInNavigation)?.viewWillSwipeBack()
              return false
          } else {
              return true
          }
      }
      return true
    }
    func hasNotAcceptSwipeBackGesture(topViewController: UIViewController) -> Bool {
        return false
    }
}
