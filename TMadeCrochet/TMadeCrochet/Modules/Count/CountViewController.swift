//
//  CountViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class CountViewController: BaseViewController {
    var presenter: ViewToPresenterCountProtocol?
    
    @IBOutlet weak var collectionView: BaseCollectionView!
    
    private let width: CGFloat = UIScreen.main.bounds.width
    private let height: CGFloat = 200
    private let lineSpacing: CGFloat = 5
    private let interitemSpacing: CGFloat = 5
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "Bộ đếm", isShowLeft: false)
        self.setupDataForCollectionView()
    }
    
    func setupDataForCollectionView() {
        let itemSize = CGSize(width: width, height: height)
        self.collectionView.dataArray = [[]]
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        self.collectionView.configure(hasPull: false,
                                 hasLoadMore: false,
                                 lineSpacing: lineSpacing,
                                 interitemSpacing: interitemSpacing,
                                 itemSize: itemSize,
                                 scrollDirection: .vertical,
                                 collectionCellClassName: CountCollectionCell.className,
                                 collectionReusableHeaderName: CountHeaderView.className,
                                 collectionReusableFooterName: CountFooterView.className,
                                 baseDelegate: self)
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
        if let countResponseData = AppConstant.countResponseData, let array = countResponseData.data, array.count > 0 {
            self.collectionView.dataArray = array
            self.collectionView.reloadData()
        }
    }
}
    

extension CountViewController: PresenterToViewCountProtocol {
    
}

extension CountViewController: BaseCollectionViewProtocol {
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
        
    }
    
    func setupHeader(_ indexPath: IndexPath, _ view: BaseCollectionReusableView) {
        if let view = view as? CountHeaderView {
            switch indexPath.section {
            case 0:
                view.setupView(text: "Bộ đếm chính")
                break
            default:
                view.setupView(text: "Bộ đếm")
            }

        }
    }
    
    func headerSize(_ section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func setupFooter(_ indexPath: IndexPath, _ view: BaseCollectionReusableView) {
        if let view = view as? CountFooterView {
            switch indexPath.section {
            case 0:
                view.setupView(text: "Bộ đếm phụ")
                break
            default:
                view.setupView(text: "Bộ đếm")
            }

        }
    }
    
    func footerSize(_ section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
