//
//  SymbolViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit
import FirebaseAnalytics

class SymbolViewController: BaseViewController {
    var presenter: ViewToPresenterSymbolProtocol?

    @IBOutlet weak var collectionView: BaseCollectionView!
    var data: [[Symbol]] = []
    private let size: CGFloat = (UIScreen.main.bounds.width - 32 - 10)/3
    private let lineSpacing: CGFloat = 5
    private let interitemSpacing: CGFloat = 5
    var currentIndexPath: IndexPath = IndexPath.SubSequence(row: 0, section: 0)
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "symbol_screen_header_title".Localizable(), isShowLeft: false)
        self.setupDataForCollectionView()
        self.startGoogleMobileAdsSDK()
    }
    
    func setupDataForCollectionView() {
        let itemSize = CGSize(width: size, height: size)
        self.collectionView.dataArray = [[]]
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        self.collectionView.configure(hasPull: false,
                                 hasLoadMore: false,
                                 lineSpacing: lineSpacing,
                                 interitemSpacing: interitemSpacing,
                                 itemSize: itemSize,
                                 scrollDirection: .vertical,
                                 collectionCellClassName: SymbolCollectionCell.className,
                                 baseDelegate: self)
        self.collectionView.register(UINib(nibName: SymbolHeaderView.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SymbolHeaderView.className)
        self.collectionView.register(UINib(nibName: UpdateInfoView.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UpdateInfoView.className)
    }
    
    @objc func loadData() {
        if let symbolResponseData = AppConstant.symbolResponseData, let array = symbolResponseData.data, array.count > 0 {
            self.data = array
            self.collectionView.dataArray = self.data
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadData),
            name: NSNotification.Name("com.tmadecrochet.reloadData"),
            object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func updateDataWhenAdsHiden() {
        if self.data.count > 0, self.data.count > currentIndexPath.section && self.data[currentIndexPath.section].count > currentIndexPath.row {
            self.data[currentIndexPath.section][currentIndexPath.row].isAds = false
            AppConstant.symbolResponseData = SymbolResponseData.init(newData: self.data)
            self.loadData()
        }
    }
    
    func showAdsView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showAds()
        }
    }
}
    

extension SymbolViewController: PresenterToViewSymbolProtocol {
    
}

extension SymbolViewController: BaseCollectionViewProtocol {
    // MARK: - Collection delegate, datasource
    private func updateUI(selectedIndex: IndexPath) {
        
    }
    
    @objc func setupCell(_ indexPath: IndexPath, _ dataItem: Any, _ cell: BaseCollectionViewCell) {
        if let cell = cell as? SymbolCollectionCell {
            cell.setupCell(object: dataItem)
        }
    }
    
    @objc func didSelectItem(_ indexPath: IndexPath, _ dataItem: Any, _ cell: UICollectionViewCell) {
        guard let data = dataItem as? Symbol else { return }
        Analytics.logEvent("Symbols", parameters: [
            "stitch" : (indexPath.row + 1), "stitch_name" : (data.symbolName ?? "") as NSObject
               ])
        if let isAds = data.isAds, isAds {
            self.currentIndexPath = indexPath
            PopupHelper.shared.showArlertView(baseViewController: self, title: "unclock_content_by_watching_ads".Localizable(), activeTitle: "yes_text".Localizable(), activeAction: {
                PopupHelper.shared.dismissView()
                self.showAdsView()
            }, cancelTitle: "no_text".Localizable(), cancelAction: {})
        } else {
            self.presenter?.navigateToDetail(symbol: data, currentIndexPath: self.currentIndexPath)
            
        }
    }
    
    func collectionReusableView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       switch kind {
        case UICollectionView.elementKindSectionHeader:
            if kind == UICollectionView.elementKindSectionHeader {
               let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SymbolHeaderView.className, for: indexPath)
                if let headerView = headerView as? SymbolHeaderView {
                    switch indexPath.section {
                    case 0:
                        headerView.setupView(text: "basic_stitches".Localizable(), imageStr: "ico_symbol_1")
                        break
                    case 1:
                        headerView.setupView(text: "puff_stitches".Localizable(), imageStr: "ico_symbol_2")
                        break
                    case 2:
                        headerView.setupView(text: "increases_stitches".Localizable(), imageStr: "ico_symbol_3")
                        break
                    case 3:
                        headerView.setupView(text: "decreases_stitches".Localizable(), imageStr: "ico_symbol_4")
                        break
                    default:
                        headerView.setupView(text: "basic_stitches".Localizable(), imageStr: "ico_symbol_1")
                    }
                }
               return headerView
           }
            return UICollectionReusableView()
       case UICollectionView.elementKindSectionFooter:
          switch indexPath.section {
          case 3:
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UpdateInfoView.className, for: indexPath)
                if let footerView = footerView as? UpdateInfoView {
                    footerView.setupView(text: "blo_flo_stitches".Localizable(), imageStr: "ico_symbol_5")
                }
                return footerView
          default:
              return UICollectionReusableView()
          }
         default:
            return UICollectionReusableView()
        }
    }
    
    func headerSize(_ section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 70)
    }
    
    func footerSize(_ section: Int) -> CGSize {
        switch section {
        case 3:
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 270)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
