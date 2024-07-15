//
//  BaseCollectionView.swift
//  Probit
//
//  Created by Nguyen Huy Hoang on 21/05/2024.
//

import UIKit
import Foundation

@objc protocol BaseCollectionViewProtocol {
    @objc func setupCell(_ indexPath: IndexPath, _ dataItem: Any, _ cell: BaseCollectionViewCell)
    @objc optional func loadMoreData()
    @objc optional func pullToRefreshData()
    @objc optional func getCurrentPage(_ page: Int)
    @objc optional func didSelectItem(_ indexPath: IndexPath, _ dataItem: Any, _ cell: UICollectionViewCell)
    @objc optional func layoutSize(_ collectionView: UICollectionView,
                                   _ layout : UICollectionViewLayout,
                                   _ indexPath: IndexPath) -> CGSize
    @objc optional func setupHeader(_ indexPath: IndexPath, _ view: BaseCollectionReusableView)
    @objc optional func headerSize(_ section: Int) -> CGSize
    @objc optional func footerSize(_ section: Int) -> CGSize
}

class BaseCollectionView: UICollectionView {
    var hasLoadMore: Bool = true
    var itemSize: CGSize? = nil
    var lineSpacing: CGFloat = 0
    var interitemSpacing: CGFloat = 0
    var collectionCellClassName: String?
    var collectionReusableHeaderName: String?
    var dataArray: [[Any]] = [[]] {
        didSet {
            self.reloadData()
            self.collectionViewLayout.invalidateLayout()
            self.layoutIfNeeded()
        }
    }
    
    weak var baseDelegate: BaseCollectionViewProtocol?
    
    func configure(hasPull: Bool = true,
                   hasLoadMore: Bool = true,
                   isFromNib: Bool = true,
                   data: [[Any]]? = nil,
                   lineSpacing: CGFloat = 0,
                   interitemSpacing: CGFloat = 0,
                   itemSize: CGSize = .zero,
                   scrollDirection: UICollectionView.ScrollDirection = .horizontal,
                   collectionCellClassName: String,
                   collectionReusableHeaderName: String,
                   baseDelegate: BaseCollectionViewProtocol?) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumLineSpacing = lineSpacing
        layout.scrollDirection = scrollDirection
        layout.minimumInteritemSpacing = interitemSpacing
        self.collectionViewLayout = layout
        
        self.register(UINib(nibName: "HeaderViewCV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderViewCV")
        
        self.itemSize = itemSize
        self.collectionCellClassName = collectionCellClassName
        self.collectionReusableHeaderName = collectionReusableHeaderName
        self.baseDelegate = baseDelegate
         
        if let data = data {
            self.dataArray = data
        }
        self.delegate = self
        self.dataSource = self
        self.hasLoadMore = hasLoadMore
        
        if isFromNib {
            self.register(UINib(nibName: collectionCellClassName, bundle: nil), forCellWithReuseIdentifier: collectionCellClassName)
        }
        
        if hasPull {
            self.addPullRefresh()
        }
        if hasLoadMore {
            addLoadmore()
        }
    }
    
    deinit {
        self.baseDelegate = nil
        self.collectionCellClassName = nil
        self.delegate = nil
        self.dataSource = nil
    }
    
    func addPullRefresh() {
        self.cr.addHeadRefresh(handler: {
            if self.cr.isRemoveLoadMore() == true, self.hasLoadMore {
                self.addLoadmore()
            }
            if let pullToRefresh = self.baseDelegate?.pullToRefreshData {
                // Calling didSelectRow that was set in ViewController.
                pullToRefresh()
            }
        })
    }
    
    func addLoadmore() {
        self.cr.addFootRefresh {
            if let loadMore = self.baseDelegate?.loadMoreData {
                // Calling didSelectRow that was set in ViewController.
                loadMore()
            }
        }
    }
}

extension BaseCollectionView: UICollectionViewDataSource {
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentCell = collectionCellClassName ?? ""
        let cell = self.dequeueReusableCell(withReuseIdentifier: currentCell, for: indexPath)
        if let baseCell = cell as? BaseCollectionViewCell,
           self.dataArray.count > indexPath.section && self.dataArray[indexPath.section].count > indexPath.row {
            self.baseDelegate?.setupCell(indexPath, self.dataArray[indexPath.section][indexPath.row], baseCell)
            return baseCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count > section ? dataArray[section].count : 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
       switch kind {
            case UICollectionView.elementKindSectionHeader:
           if dataArray.count > 0, kind == UICollectionView.elementKindSectionHeader {
               let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.collectionReusableHeaderName ?? "", for: indexPath)
               if let headerView = headerView as? BaseCollectionReusableView {
                   self.baseDelegate?.setupHeader?(indexPath, headerView)
               }
               return headerView
           }

            return UICollectionReusableView()
             default:
                return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.baseDelegate?.headerSize?(section) ?? CGSize(width: 0, height: 0)
    }

}

extension BaseCollectionView: UICollectionViewDelegate {
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        let data = self.dataArray[indexPath.section][indexPath.row]
        if let didSelectItem = self.baseDelegate?.didSelectItem {
            didSelectItem(indexPath, data, cell)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        if let getCurrentPage = self.baseDelegate?.getCurrentPage {
            getCurrentPage(page)
        }
    }
}

extension BaseCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layoutSize = self.baseDelegate?.layoutSize {
            return layoutSize(collectionView, collectionViewLayout, indexPath)
        }
        return self.itemSize ?? .zero
    }
}
