//
//  TutorialViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit
import GoogleMobileAds

class TutorialViewController: BaseViewController, GADBannerViewDelegate {
    var presenter: ViewToPresenterTutorialProtocol?
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var collectionView: BaseCollectionView!
    
    private var isMobileAdsStartCalled = false
    private var isViewDidAppearCalled = false
    
    private let width: CGFloat = (UIScreen.main.bounds.width - 32 - 10)/2
    private let height: CGFloat =  (UIScreen.main.bounds.width - 32 - 10)/2 + 50
    private let lineSpacing: CGFloat = 30
    private let interitemSpacing: CGFloat = 5
    var data: [Tutorial] = []
    var currentTutorial: Tutorial?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "tutorial_screen_header_title".Localizable(), isShowLeft: false)
        self.loadAdsBanner()
        self.setupDataForCollectionView()
        self.startGoogleMobileAdsSDK()
    }
    
    func setupDataForCollectionView() {
        let itemSize = CGSize(width: width, height: height)
        self.collectionView.dataArray = [[]]
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 66, right: 0)
        self.collectionView.configure(hasPull: false,
                                 hasLoadMore: false,
                                 lineSpacing: lineSpacing,
                                 interitemSpacing: interitemSpacing,
                                 itemSize: itemSize,
                                 scrollDirection: .vertical,
                                 collectionCellClassName: TutorialCollectionCell.className,
                                 baseDelegate: self)

    }
    
    func loadAdsBanner() {
        // Replace this ad unit ID with your own ad unit ID.
        bannerView.adUnitID = AppConstant.Ads.bannerAdsId
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    func loadData() {
        if let countResponseData = AppConstant.tutorialResponseData, let array = countResponseData.data, array.count > 0 {
            self.data = array
            self.collectionView.dataArray = [self.data]
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - GADBannerViewDelegate methods

    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print(#function)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print(#function + ": " + error.localizedDescription)
    }

    func bannerViewDidRecordClick(_ bannerView: GADBannerView) {
      print(#function)
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print(#function)
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print(#function)
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print(#function)
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print(#function)
    }
    
    override func updateDataWhenAdsHiden() {
        if let data = self.currentTutorial {
            self.presenter?.navigateToDetail(tutorial: data)
        }
    }

}
    

extension TutorialViewController: PresenterToViewTutorialProtocol {
    
}

extension TutorialViewController: BaseCollectionViewProtocol {
    // MARK: - Collection delegate, datasource
    private func updateUI(selectedIndex: IndexPath) {
        
    }
    
    @objc func setupCell(_ indexPath: IndexPath, _ dataItem: Any, _ cell: BaseCollectionViewCell) {
        if let cell = cell as? TutorialCollectionCell {
            cell.setupCell(object: dataItem)
        }
    }
    
    @objc func didSelectItem(_ indexPath: IndexPath, _ dataItem: Any, _ cell: UICollectionViewCell) {
        guard let data = dataItem as? Tutorial else { return }
        self.currentTutorial = data
        if let count = AppConstant.countShowAdsWhenOpenTutorial, count > 0 {
            if count >= AppConstant.adsTurorialCount {
                self.showAds()
                AppConstant.countShowAdsWhenOpenTutorial = 1
            } else {
                let newCount = count + 1
                AppConstant.countShowAdsWhenOpenTutorial = newCount
                self.presenter?.navigateToDetail(tutorial: data)
            }
        } else {
            AppConstant.countShowAdsWhenOpenTutorial = 1
            self.presenter?.navigateToDetail(tutorial: data)
        }
    }
}
