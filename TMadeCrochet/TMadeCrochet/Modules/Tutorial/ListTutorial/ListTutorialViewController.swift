//
//  ListTutorialViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit
import GoogleMobileAds

class ListTutorialViewController: BaseViewController, GADBannerViewDelegate {
    var presenter: ViewToPresenterListTutorialProtocol?
    
    @IBOutlet weak var collectionView: BaseCollectionView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    private let width: CGFloat = UIScreen.main.bounds.width
    private let height: CGFloat =  150
    private let lineSpacing: CGFloat = 20
    private let interitemSpacing: CGFloat = 5
    var data: [TutorialItem] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "tutorial_screen_header_title".Localizable(), isShowLeft: true)
        self.loadAdsBanner()
        self.setupDataForCollectionView()
    }
    
    func setupDataForCollectionView() {
        if let tutorial = self.presenter?.tutorial, let list = tutorial.list, list.count > 0 {
            self.data = list
        }
        let itemSize = CGSize(width: width, height: height)
        self.collectionView.dataArray = [self.data]
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 66, right: 0)
        self.collectionView.configure(hasPull: false,
                                 hasLoadMore: false,
                                 lineSpacing: lineSpacing,
                                 interitemSpacing: interitemSpacing,
                                 itemSize: itemSize,
                                 scrollDirection: .vertical,
                                 collectionCellClassName: ListTutorialCollectionCell.className,
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
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

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

}
    

extension ListTutorialViewController: PresenterToViewListTutorialProtocol {
    
}

extension ListTutorialViewController: BaseCollectionViewProtocol {
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
    }
}
