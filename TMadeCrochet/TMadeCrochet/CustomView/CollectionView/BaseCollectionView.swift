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
}

class BaseCollectionView: UICollectionView {
    var hasLoadMore: Bool = true
    var itemSize: CGSize? = nil
    var lineSpacing: CGFloat = 0
    var interitemSpacing: CGFloat = 0
    var collectionCellClassName: String?
    
    var dataArray: [Any] = [] {
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
                   data: [Any]? = nil,
                   lineSpacing: CGFloat = 0,
                   interitemSpacing: CGFloat = 0,
                   itemSize: CGSize = .zero,
                   scrollDirection: UICollectionView.ScrollDirection = .horizontal,
                   collectionCellClassName: String,
                   baseDelegate: BaseCollectionViewProtocol?) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumLineSpacing = lineSpacing
        layout.scrollDirection = scrollDirection
        layout.minimumInteritemSpacing = interitemSpacing
        self.collectionViewLayout = layout
        self.itemSize = itemSize
        self.collectionCellClassName = collectionCellClassName
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
           self.dataArray.count > indexPath.row {
            self.baseDelegate?.setupCell(indexPath, dataArray[indexPath.row], baseCell)
            return baseCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension BaseCollectionView: UICollectionViewDelegate {
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        let data = dataArray[indexPath.row]
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
