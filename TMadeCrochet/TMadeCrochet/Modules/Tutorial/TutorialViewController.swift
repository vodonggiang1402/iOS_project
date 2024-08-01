//
//  TutorialViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class TutorialViewController: BaseViewController {
    var presenter: ViewToPresenterTutorialProtocol?
    
    @IBOutlet weak var collectionView: BaseCollectionView!
    
    private let width: CGFloat = (UIScreen.main.bounds.width - 32 - 10)/2
    private let height: CGFloat =  (UIScreen.main.bounds.width - 32 - 10)/2 + 50
    private let lineSpacing: CGFloat = 30
    private let interitemSpacing: CGFloat = 5
    var data: [Tuttorial] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "tutorial_screen_header_title".Localizable(), isShowLeft: false)
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
                                 collectionCellClassName: TutorialCollectionCell.className,
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
        if let countResponseData = AppConstant.tutorialResponseData, let array = countResponseData.data, array.count > 0 {
            self.data = array
            self.collectionView.dataArray = [self.data]
            self.collectionView.reloadData()
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
        guard dataItem is Count else { return }
        
    }
}
