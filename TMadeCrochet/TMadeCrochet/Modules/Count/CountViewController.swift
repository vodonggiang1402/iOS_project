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
                                 baseDelegate: self)
        self.collectionView.register(UINib(nibName: CountHeaderView.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CountHeaderView.className)
        
        self.collectionView.register(UINib(nibName: CountFooterView.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CountFooterView.className)
        
        self.collectionView.register(UINib(nibName: AddCountFooterView.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddCountFooterView.className)

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
    
    func isEmptySection() -> Bool {
        if self.data.count > 1 {
            let list = self.data[1]
            if list.count > 0 {
                return true
            }
        }
        return false
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
    
    func headerSize(_ section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 80)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func footerSize(_ section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        case 1:
            return CGSize(width: UIScreen.main.bounds.width, height: isEmptySection() ? 80 : 0)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionReusableView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       switch kind {
        case UICollectionView.elementKindSectionHeader:
            if self.data.count > 0, kind == UICollectionView.elementKindSectionHeader {
               let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CountHeaderView.className, for: indexPath)
                if let headerView = headerView as? CountHeaderView {
                    headerView.delegate = self
                    switch indexPath.section {
                    case 0:
                        headerView.setupView(text: "Bộ đếm chính")
                        break
                    default:
                        headerView.setupView(text: "Bộ đếm")
                    }

                }
               return headerView
           }
            return UICollectionReusableView()
        case UICollectionView.elementKindSectionFooter:
           switch indexPath.section {
           case 0:
                 let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CountFooterView.className, for: indexPath)
                   if let footerView = footerView as? CountFooterView {
                       footerView.delegate = self
                       switch indexPath.section {
                       case 0:
                           footerView.setupView(text: "Bộ đếm phụ")
                           break
                       default:
                           footerView.setupView(text: "Bộ đếm")
                       }

                   }
                 return footerView
           case 1:
               let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddCountFooterView.className, for: indexPath)
               if let footerView = footerView as? AddCountFooterView {
                   footerView.delegate = self
               }
               return footerView
           default:
               return UICollectionReusableView()
           }
         default:
            return UICollectionReusableView()
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
        PopupHelper.shared.showCommonPopup(baseViewController: self, titleHeader: "Nhập thông tin", activeTitle: "Đồng ý", activeAction: { title in
            self.addNewCount(text: title)
        }, cancelTitle: "Bỏ qua") {}
    }
    
    func addNewCount(text: String) {
        if self.data.count > 1 {
            self.data[1].append(Count.init(isGlobal: false, countName: text, count: 1, color: self.getRamdomColor()))
            AppConstant.countResponseData = CountResponseData.init(newData: self.data)
        } else {
            var array: [Count] = []
            array.append(Count.init(isGlobal: false, countName: text, count: 1, color: self.getRamdomColor()))
            self.data.append(array)
            AppConstant.countResponseData = CountResponseData.init(newData: self.data)
        }
        self.loadData()
        self.scrollToBottom()
    }
    
    func scrollToBottom() {
        let section = self.collectionView.numberOfSections - 1
        let item = self.collectionView.numberOfItems(inSection: section) - 1
        let indexPath = IndexPath(item: item, section: section)
        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    func getRamdomColor()-> String {
        let array = ["CE9C9D", "80ADBC", "#1B4F93",
                     "DFD8AB", "CAB08B", "E54646",
                     "F9F400", "489620", "008C5E"]
        return array.randomElement()!
    }
}

extension CountViewController: AddCountFooterViewDelegate {
    
}

extension CountViewController: CountCollectionCellDelegate {
    func minusButtonTap(indexPath: IndexPath) {
        if self.data.count > 0, self.data.count > indexPath.section && self.data[indexPath.section].count > indexPath.row {
            let itemSlected = self.data[indexPath.section][indexPath.row]
            if let count = itemSlected.count, count > 1 {
                self.data[indexPath.section][indexPath.row].count = count - 1
                AppConstant.countResponseData = CountResponseData.init(newData: self.data)
                self.loadData()
            }
        }
    }
    
    func plusButtonTap(indexPath: IndexPath) {
        if self.data.count > 0, self.data.count > indexPath.section && self.data[indexPath.section].count > indexPath.row {
            let itemSlected = self.data[indexPath.section][indexPath.row]
            if let count = itemSlected.count {
                self.data[indexPath.section][indexPath.row].count = count + 1
                AppConstant.countResponseData = CountResponseData.init(newData: self.data)
                self.loadData()
            }
        }
    }
    
    func moreButtonTap(indexPath: IndexPath) {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
        let editAction: UIAlertAction = UIAlertAction(title: "Chỉnh sửa", style: .default) { action -> Void in
            self.editAction(indexPath: indexPath)
        }

        let resetAction: UIAlertAction = UIAlertAction(title: "Đếm lại", style: .default) { action -> Void in
            self.resetAction(indexPath: indexPath)
        }

        let deleteAction: UIAlertAction = UIAlertAction(title: "Xoá đếm", style: .destructive) { action -> Void in
            self.deleteAction(indexPath: indexPath)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Bỏ qua", style: .cancel) { action -> Void in

        }

        // add actions
        actionSheetController.addAction(editAction)
        actionSheetController.addAction(resetAction)
        actionSheetController.addAction(deleteAction)
        actionSheetController.addAction(cancelAction)

        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
    
    func editAction(indexPath: IndexPath) {
        PopupHelper.shared.showCommonPopup(baseViewController: self, titleHeader: "Nhập thông tin", activeTitle: "Đồng ý", activeAction: { title in
            self.resetCount(indexPath: indexPath, text: title)
        }, cancelTitle: "Bỏ qua") {}
    }
    
    func resetCount(indexPath: IndexPath, text: String) {
        if self.data.count > 0, self.data.count > indexPath.section && self.data[indexPath.section].count > indexPath.row {
            self.data[indexPath.section][indexPath.row].countName = text
            AppConstant.countResponseData = CountResponseData.init(newData: self.data)
            self.loadData()
        }
    }
    
    func resetAction(indexPath: IndexPath) {
        if self.data.count > 0, self.data.count > indexPath.section && self.data[indexPath.section].count > indexPath.row {
            self.data[indexPath.section][indexPath.row].count = 1
            AppConstant.countResponseData = CountResponseData.init(newData: self.data)
            self.loadData()
        }
    }
    
    func deleteAction(indexPath: IndexPath) {
        if self.data.count > 0, self.data.count > indexPath.section && self.data[indexPath.section].count > indexPath.row {
            var group = self.data[indexPath.section]
            group.remove(at: indexPath.row)
            self.data[indexPath.section] = group
            AppConstant.countResponseData = CountResponseData.init(newData: self.data)
            self.loadData()
        }
    }
}
