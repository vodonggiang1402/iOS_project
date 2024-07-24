//
//  TabbarViewController.swift
//  Probit
//
//  Created by Giang Vo on 01/07/2024.
//
//

import UIKit
import GoogleMobileAds

class TabbarViewController: UITabBarController, AppOpenAdManagerDelegate {
    private var tabbarItems = [TabBarItem]()
    
    var secondsRemaining: Int = 2
    var countdownTimer: Timer?
    private var isMobileAdsStartCalled = false
    
    // MARK: - Properties
    var presenter: ViewToPresenterTabbarProtocol?
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        presenter?.viewDidLoad()
    }
    
    func loadAds() {
        AppOpenAdManager.shared.appOpenAdManagerDelegate = self
        startTimer()

        GoogleMobileAdsConsentManager.shared.gatherConsent(from: self) {
          [weak self] consentError in
          guard let self else { return }

          if let consentError {
            // Consent gathering failed.
            print("Error: \(consentError.localizedDescription)")
          }

          if GoogleMobileAdsConsentManager.shared.canRequestAds {
            self.startGoogleMobileAdsSDK()
          }
        }

        // This sample attempts to load ads using consent obtained in the previous session.
        if GoogleMobileAdsConsentManager.shared.canRequestAds {
          startGoogleMobileAdsSDK()
        }
    }
    
    @objc func decrementCounter() {
      secondsRemaining -= 1
      guard secondsRemaining <= 0 else {
        return
      }
      countdownTimer?.invalidate()
      AppOpenAdManager.shared.showAdIfAvailable()
    }

    private func startGoogleMobileAdsSDK() {
      DispatchQueue.main.async {
        guard !self.isMobileAdsStartCalled else { return }

        self.isMobileAdsStartCalled = true

        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start()

        // Load an ad.
        Task {
          await AppOpenAdManager.shared.loadAd()
        }
      }
    }

    func startTimer() {
      countdownTimer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(TabbarViewController.decrementCounter),
        userInfo: nil,
        repeats: true)
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
        tabBar.backgroundColor = UIColor.color_fafafa_1818181
        let spacingTopView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        spacingTopView.backgroundColor = UIColor.color_fafafa_1818181
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
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.color_7f7f7f_565656,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        tabBar.unselectedItemTintColor = UIColor.clear
        
        let tabbarItem = UITabBarItem(title: tabName,
                                      image: image?.withRenderingMode(.alwaysOriginal),
                                      selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        tabbarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        tabbarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        tabbarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        tabbarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 1)
        
        viewController.tabBarItem = tabbarItem
    }
    
    // MARK: AppOpenAdManagerDelegate
    func appOpenAdManagerAdDidComplete(_ appOpenAdManager: AppOpenAdManager) {
      
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
            case .tutorial:
                let controller = setupController(TutorialRouter().createModule(),
                                                 tabName: item.title,
                                                 image: item.unselectedImage,
                                                 selectedImage: item.selectedImage)
                listViewControllers.append(controller)
            case .setting:
                let controller = setupController(SettingRouter().createModule(),
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
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.color_main_app_pink,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.color_7f7f7f_565656,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
        tabBar.unselectedItemTintColor = UIColor.clear
        
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
