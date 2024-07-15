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
    var data: [[Count]] = [[]]
    
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
            self.data = array
            self.collectionView.dataArray = self.data
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
        if let cell = cell as? CountCollectionCell {
            cell.currentIndexPath = indexPath
            cell.delegate = self
            cell.setupCell(object: dataItem)
        }
    }
    
    @objc func didSelectItem(_ indexPath: IndexPath, _ dataItem: Any, _ cell: UICollectionViewCell) {
        guard let data = dataItem as? Count else { return }
        
    }
    
    func setupHeader(_ indexPath: IndexPath, _ view: BaseCollectionReusableView) {
        if let view = view as? CountHeaderView {
            view.delegate = self
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
            view.delegate = self
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

extension CountViewController: CountHeaderViewDelegate {
    func refreshButtonAction(indexPath: IndexPath) {
        if self.data.count > 0, self.data.count > indexPath.section && self.data[indexPath.section].count > indexPath.row {
            self.data[indexPath.section][indexPath.row].count = 1
            AppConstant.countResponseData = CountResponseData.init(newData: self.data)
            self.loadData()
        }
    }
}

extension CountViewController: CountFooterViewDelegate {
    func addButtonAction() {
        PopupHelper.shared.showCommonPopup(baseViewController: self, titleHeader: "Nhập thông tin", activeTitle: "Đồng ý", activeAction: {_ in
            
        }, cancelTitle: "Bỏ qua") {
            
        }
    }
}

extension CountViewController: CountCollectionCellDelegate {
    func minusTap(indexPath: IndexPath) {
        if self.data.count > 0, self.data.count > indexPath.section && self.data[indexPath.section].count > indexPath.row {
            let itemSlected = self.data[indexPath.section][indexPath.row]
            if let count = itemSlected.count, count > 1 {
                self.data[indexPath.section][indexPath.row].count = count - 1
                AppConstant.countResponseData = CountResponseData.init(newData: self.data)
                self.loadData()
            }
        }
    }
    
    func plusTap(indexPath: IndexPath) {
        if self.data.count > 0, self.data.count > indexPath.section && self.data[indexPath.section].count > indexPath.row {
            let itemSlected = self.data[indexPath.section][indexPath.row]
            if let count = itemSlected.count {
                self.data[indexPath.section][indexPath.row].count = count + 1
                AppConstant.countResponseData = CountResponseData.init(newData: self.data)
                self.loadData()
            }
        }
    }
}
