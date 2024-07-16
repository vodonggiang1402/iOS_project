//
//  TabbarViewController.swift
//  Probit
//
//  Created by Giang Vo on 01/07/2024.
//
//

import UIKit

class TabbarViewController: UITabBarController {
    private var tabbarItems = [TabBarItem]()
    // MARK: - Properties
    var presenter: ViewToPresenterTabbarProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDarkMode()
    }
    
    func setupTabbarItems(items: [TabBarItem]) {
        tabbarItems = items
        prepareTabbarControllers()
        setupCustomTabBar()
    }
    
    private func setupCustomTabBar() {
        tabBar.backgroundColor = UIColor.white
        let spacingTopView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        spacingTopView.backgroundColor = UIColor.white
        view.addSubview(spacingTopView)
        tabBar.addSubview(spacingTopView)
    }
    
    // MARK: - Setup dark mode
    func setupDarkMode() {
        if let listViewControllers = self.viewControllers, listViewControllers.count > 0 {
            for item in tabbarItems {
                updateTabbarItem(viewController: listViewControllers[tabbarItems.firstIndex(of: item) ?? 0],
                                 tabName: item.title,
                                 image: item.unselectedImage,
                                 selectedImage: item.selectedImage)
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // Trait collection has already changed
        super.traitCollectionDidChange(previousTraitCollection)
        setupDarkMode()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // Trait collection will change. Use this one so you know what the state is changing to.
        super.willTransition(to: newCollection, with: coordinator)
        setupDarkMode()
    }
    
    func updateTabbarItem(viewController: UIViewController,
                          tabName: String,
                          image: UIImage?,
                          selectedImage: UIImage?) {
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.color_main_app_pink,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)]
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.color_main_app_gray,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        tabBar.unselectedItemTintColor = UIColor.gray
        
        let tabbarItem = UITabBarItem(title: tabName,
                                      image: image?.withRenderingMode(.alwaysOriginal),
                                      selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        tabbarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        tabbarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        tabbarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        tabbarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 1)
        
        viewController.tabBarItem = tabbarItem
    }
}

extension TabbarViewController: PresenterToViewTabbarProtocol{
    // TODO: Implement View Output Methods
}

extension TabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

extension TabbarViewController {
    private func prepareTabbarControllers() {
        var listViewControllers = [UINavigationController]()
        for item in tabbarItems {
            switch item {
            case .count:
                let controller = setupController(CountRouter().createModule(),
                                                 tabName: item.title,
                                                 image: item.unselectedImage,
                                                 selectedImage: item.selectedImage)
                listViewControllers.append(controller)
            case .symbol:
                let controller = setupController(SymbolRouter().createModule(),
                                                 tabName: item.title,
                                                 image: item.unselectedImage,
                                                 selectedImage: item.selectedImage)
                listViewControllers.append(controller)
            case .pattern:
                let controller = setupController(PatternRouter().createModule(),
                                                 tabName: item.title,
                                                 image: item.unselectedImage,
                                                 selectedImage: item.selectedImage)
                listViewControllers.append(controller)
            case .setting:
                let controller = setupController(ProfileRouter().createModule(),
                                                 tabName: item.title,
                                                 image: item.unselectedImage,
                                                 selectedImage: item.selectedImage)
                listViewControllers.append(controller)
            }
        }
        self.viewControllers = listViewControllers
    }
    
    func setupController(_ viewController: UIViewController,
                         tabName: String,
                         image: UIImage?,
                         selectedImage: UIImage?) -> UINavigationController {
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)]
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        tabBar.unselectedItemTintColor = UIColor.gray
        
        let tabbarItem = UITabBarItem(title: tabName,
                                      image: image?.withRenderingMode(.alwaysOriginal),
                                      selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        tabbarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        tabbarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        tabbarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        tabbarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 1)
        
        viewController.tabBarItem = tabbarItem
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.view.backgroundColor = UIColor.white
        return navigation
    }
    
    func tabBarIsVisible() ->Bool {
        return orgFrameView == nil
    }
    
    private struct AssociatedKeys {
        // Declare a global var to produce a unique address as the assoc object handle
        static var orgFrameView:     UInt8 = 0
        static var movedFrameView:   UInt8 = 1
    }
    
    var orgFrameView:CGRect? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.orgFrameView) as? CGRect }
        set { objc_setAssociatedObject(self, &AssociatedKeys.orgFrameView, newValue, .OBJC_ASSOCIATION_COPY) }
    }
    
    var movedFrameView:CGRect? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.movedFrameView) as? CGRect }
        set { objc_setAssociatedObject(self, &AssociatedKeys.movedFrameView, newValue, .OBJC_ASSOCIATION_COPY) }
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let movedFrameView = movedFrameView {
            view.frame = movedFrameView
        }
    }
    
}
