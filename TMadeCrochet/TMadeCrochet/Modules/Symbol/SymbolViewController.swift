//
//  SymbolViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class SymbolViewController: BaseViewController {
    var presenter: ViewToPresenterSymbolProtocol?

    @IBOutlet weak var collectionView: BaseCollectionView!
    
    private let size: CGFloat = (UIScreen.main.bounds.width - 32 - 10)/3
    private let lineSpacing: CGFloat = 5
    private let interitemSpacing: CGFloat = 5
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "Mũi móc", isShowLeft: false)
        self.setupDataForCollectionView()
    }
    
    func setupDataForCollectionView() {
        let itemSize = CGSize(width: size, height: size)
        self.collectionView.dataArray = [[]]
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 16, right: 0)
        self.collectionView.configure(hasPull: false,
                                 hasLoadMore: false,
                                 lineSpacing: lineSpacing,
                                 interitemSpacing: interitemSpacing,
                                 itemSize: itemSize,
                                 scrollDirection: .vertical,
                                 collectionCellClassName: SymbolCollectionCell.className,
                                      collectionReusableHeaderName: HeaderViewCV.className,
                                 baseDelegate: self)
    }
    
    func loadData() {
        if let symbolResponseData = AppConstant.symbolResponseData, let array = symbolResponseData.data, array.count > 0 {
            self.collectionView.dataArray = array
            self.collectionView.reloadData()
        }
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
        self.presenter?.navigateToDetail(symbol: data)
    }
    
    func setupHeader(_ indexPath: IndexPath, _ view: BaseCollectionReusableView) {
        if let view = view as? HeaderViewCV {
            switch indexPath.section {
            case 0:
                view.setupView(text: "Mũi cơ bản")
                break
            case 1:
                view.setupView(text: "Mũi hạt bắp")
                break
            default:
                view.setupView(text: "Mũi cơ bản")
            }

        }
    }
    
    func headerSize(_ section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 70)
    }
}
