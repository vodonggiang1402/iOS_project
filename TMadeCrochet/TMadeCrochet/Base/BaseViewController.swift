//
//  BaseViewController.swift
//  TMadeCrochet
//
//  Created by Vo Dong Giang on 1/7/24.
//

import Foundation
import UIKit
import GoogleMobileAds

class BaseViewController: UIViewController, ViewControllerInNavigation, GADFullScreenContentDelegate {
 
    private var interstitial: GADInterstitialAd?
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        // set delegate
        self.delegateSwipeBack(of: self, to: self)
        
        // enable/disable swipeback
        if let count = self.numberViewController, count > 1 {
            self.enableSwipeBack(enable: true, for: self)
        } else {
            self.enableSwipeBack(enable: false, for: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    func viewWillSwipeBack() {
        
    }
   
    // MARK: - Navigation Bar
    func hideNavigationBar(isHide: Bool = true) {
        self.navigationController?.navigationBar.isHidden = isHide
        if !isHide {
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    func setupNavigationBar(title: String = "", isShowLeft: Bool) {
        let titleView = TitleViewNavigationBar()
        titleView.setupTitleView(title: title)
        titleView.backgroundColor = .clear
        self.navigationItem.titleView = titleView
        if isShowLeft {
            self.addLeftBarItem()
        } else {
            self.removeLeftBarButton()
        }
        setupNavigationBarColor()
    }
    
    private func setupNavigationBarColor() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let navColor = UIColor.color_fafafa_1818181
        let navImage = navColor.navBarImage()
        let underLineImage = UIColor.clear.as1ptImage()
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = underLineImage
            appearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
            appearance.backgroundColor = navColor
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
            navigationBar.backgroundColor = navColor
        } else {
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.clear]
            navigationBar.setBackgroundImage(navImage, for: .default)
            navigationBar.shadowImage = underLineImage
            navigationBar.backgroundColor = navColor
        }
    }
    
    func addLeftBarItem() {
        lazy var leftButton: BarButton = {
            let button = BarButton(type: .custom)
            button.addedTouchArea = 16
            button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
            button.widthAnchor.constraint(equalToConstant: 44).isActive = true
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.imageView?.contentMode = .center
            button.backgroundColor = UIColor.clear
            button.isExclusiveTouch = true
            button.isSelected       = false
            button.addTarget(self, action: #selector(tappedLeftBarButton(sender:)), for: UIControl.Event.touchUpInside)
            button.contentHorizontalAlignment = .left
            button.titleLabel?.lineBreakMode = .byTruncatingTail
            
            button.setImage(UIImage(named: "ico_back"), for: UIControl.State.normal)
            button.setImage(UIImage(named: "ico_back"), for: UIControl.State.selected)
            
            button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                  left: 16, bottom: 0,
                                                  right: 0)
            return button
        }()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
    }
    
    func removeLeftBarButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init()
    }
    
    func addObserverKeyBoard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowNotification),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    func keyboardWillShowNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let heightSafeArea = UIApplication.shared.mainKeyWindow?.safeAreaInsets.bottom ?? 0.0
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        updateLayoutWhenKeyboardChanged(height: keyboardHeight - heightSafeArea + 5)
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: Notification) {
        updateLayoutWhenKeyboardChanged(height: 0)
    }
    
    func updateLayoutWhenKeyboardChanged(height: CGFloat) {
        
    }
    
    // MARK: - NavigationBar Action
    @objc func tappedLeftBarButton(sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getRamdomColor(colors: [String])-> String {
        let array = ["FFBF00", "9966CC", "7FFFD4", "007FFF", "993300",
                     "F0DC82", "CC5500", "C41E3A", "960018", "ACE1AF",
                     "DE3163", "007BA7", "7FFF00", "0047AB", "B87333",
                     "FF7F50", "FFFDD0", "DC143C", "00FFFF", "50C878",
                     "FFD700", "808080", "008000", "DF73FF", "4B0082",
                     "00A86B", "C3B091", "B57EDC", "CCFF00", "FF00FF",
                     "40826D"]
        let filterArray = array.filter { colors.contains($0) == false }
        return filterArray.count > 0 ? filterArray.randomElement()! : "F76A89"
    }
    
    func startGoogleMobileAdsSDK() {
        DispatchQueue.main.async {
            Task {
                await self.loadInterstitial()
            }
        }
    }
        
    func loadInterstitial() async {
        do {
          interstitial = try await GADInterstitialAd.load(
            withAdUnitID: AppConstant.Ads.interstitialAdsId, request: GADRequest())
          interstitial?.fullScreenContentDelegate = self
        } catch {
          print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
    }
    
    func showAds() {
        guard let interstitial = interstitial else {
          return print("Ad wasn't ready.")
        }
        // The UIViewController parameter is an optional.
        interstitial.present(fromRootViewController: self)
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    @objc func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    @objc func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    @objc func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        self.updateDataWhenAdsHiden()
        Task {
            await loadInterstitial()
        }
    }
    
    func updateDataWhenAdsHiden() {
        
    }
    
    func openYoutube(withId: String) {
        let appURL = NSURL(string: "youtube://www.youtube.com/watch?v=\(withId)")!
        let webURL = NSURL(string: "https://www.youtube.com/watch?v=\(withId)")!
        let application = UIApplication.shared
        if application.canOpenURL(appURL as URL) {
           application.open(appURL as URL)
        } else {
           // if Youtube app is not installed, open URL inside Safari
           application.open(webURL as URL)
        }
    }
}
