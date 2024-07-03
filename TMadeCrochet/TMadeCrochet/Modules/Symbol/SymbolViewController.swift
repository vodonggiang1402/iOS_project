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
    
    private let heightItem: CGFloat = 70
    private let widthItem: CGFloat = (UIScreen.main.bounds.width - 32)/3
    private let lineSpacing: CGFloat = 10
//    private let interitemSpacing: CGFloat = 10
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupDataForCollectionView() {
        let itemSize = CGSize(width: widthItem, height: heightItem)
        self.collectionView.configure(hasPull: false,
                                 hasLoadMore: false,
                                 lineSpacing: lineSpacing,
                                 itemSize: itemSize,
                                 scrollDirection: .vertical,
                                 collectionCellClassName: SymbolCollectionCell.className,
                                 baseDelegate: self)
    }
    
    func loadData() {
        DataManager.shared.readJSONFromFile(fileName: "symbols", type: SymbolResponseData.self) { result in
            self.collectionView.dataArray = result?.data ?? []
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDataForCollectionView()
        self.loadData()
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
       
    }
}
