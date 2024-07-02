//
//  BaseTableView.swift
//  Probit
//
//  Created by Nguyen Huy Hoang on 9/5/24.
//

import Foundation
import UIKit

enum TableEmptyType {
    case normal
    case search
}

@objc protocol BaseTableViewProtocol {
    @objc func setupCell(_ indexPath: IndexPath, _ dataItem: Any, _ cell: BaseTableViewCell)

    @objc optional func didSelectRow(_ indexPath: IndexPath, _ dataItem: Any, _ cell: UITableViewCell)
    @objc optional func willDisplayCell(_ indexPath: IndexPath, _ dataItem: Any, _ cell: UITableViewCell)
    @objc optional func didSelectHeader(_ section: Int)
    @objc optional func didSelectFooter(_ section: Int)
    @objc optional func setupHeader(_ headerView: UIView, _ section: Int)
    @objc optional func setupFooter(_ footerView: UIView, _ section: Int)
    @objc optional func cellHeightForRow(_ indexPath: IndexPath, _ cell: UITableViewCell) -> CGFloat
    @objc optional func pullToRefreshData()
    @objc optional func loadMoreData()
    @objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
}

class BaseTableView: UITableView {
    var cellheight: CGFloat?
    var noDataMessage: String?
    var hasLoadMore: Bool = false
    var emptyType: TableEmptyType = .normal
    var noDataDes: String?
    var noDataIcon: String?
    var titleColor: UIColor? = UIColor.black
    var messageColor: UIColor? = UIColor.black
    var titleFont: UIFont?
    var messageFont: UIFont?
    var tableCellClassName: String?
    var sectionHeaderView: [UIView]?
    var sectionFooterView: [UIView]?
    var tableViewCellArray: [String]?
    weak var baseDelegate: BaseTableViewProtocol?
    
    var dataArray: [[Any]] = [[]] {
        didSet {
            if dataArray.count == 0 {
                self.addNoDataView(icons: noDataIcon ?? "ico_nodata")
            } else {
                var isEmptyAllSection = true
                dataArray.forEach { section in
                    if section.count > 0 {
                        isEmptyAllSection = false
                    }
                }
                if isEmptyAllSection {
                    self.addNoDataView(icons: noDataIcon ?? "ico_nodata")
                } else {
                    self.removeNoDataView()
                }
            }
            self.reloadData()
        }
    }
    
    deinit {
        self.delegate = nil
        self.dataSource = nil
        self.baseDelegate = nil
        self.sectionHeaderView = nil
        self.sectionFooterView = nil
        self.tableViewCellArray = nil
    }
    
    func configure(tableCellClassName: String, baseDelegate: BaseTableViewProtocol,
                   hasPull: Bool = true, hasLoadMore: Bool = false, isFromNib: Bool = true,
                   data: [[Any]] = [[]]) {
        self.tableCellClassName = tableCellClassName
        self.baseDelegate = baseDelegate
        if !((data.count == 1 && data[0].count == 0) || data.isEmpty) {
            self.dataArray = data
        }
        self.delegate = self
        self.dataSource = self
        self.removeFooter()
        self.keyboardDismissMode = .onDrag
        self.hasLoadMore = hasLoadMore
        if isFromNib {
            self.register(UINib(nibName: tableCellClassName, bundle: nil), forCellReuseIdentifier: tableCellClassName)
        }
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0.0
        }
        if hasPull {
            self.addPullRefresh()
        }
        if hasLoadMore {
            addLoadmore()
        } else {
            self.cr.removeFooter()
        }
    }
    
    func addNoDataView(icons: String = "ico_nodata") {
        let data = dataArray.filter({ !$0.isEmpty })
        guard data.count == 0 else { return }
        if emptyType == .normal {
            if let desString = noDataDes, desString.count > 0 {
                self.setDataEmptyView(title: noDataMessage, message: desString, messageImage: icons, titleColor: titleColor, messageColor: messageColor, titleFont: titleFont, messageFont: messageFont)
            } else {
                self.setNoDataView(content: noDataMessage, icons: icons)
            }
        }
    }
    
    func addLoadmore() {
        self.cr.addFootRefresh {
            if let loadMore = self.baseDelegate?.loadMoreData {
                // Calling didSelectRow that was set in ViewController.
                loadMore()
            }
        }
    }
    
    func setDataEmptyView(title: String? = "", message: String? = "",
                          messageImage: String = "ico_nodata",
                          titleColor: UIColor?,
                          messageColor: UIColor?,
                          titleFont: UIFont?,
                          messageFont: UIFont?) {
        self.setEmptyView(title: title ?? "", message: message ?? "",
                          messageImage: messageImage, titleColor: titleColor,
                          messageColor: messageColor,
                          titleFont: titleFont,
                          messageFont: messageFont)
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
            self.cr.removeHeader()
        })
    }
    
    func setupDefaultCell() -> BaseTableViewCell {
        let defaultCell = BaseTableViewCell()
        defaultCell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return defaultCell
    }
    
    @objc func didSelectedHeader(gesture: UITapGestureRecognizer) {
        if let view = gesture.view, let headerCallBack = baseDelegate?.didSelectHeader {
            headerCallBack(view.tag)
        }
    }
    
    @objc func didSelectedFooter(gesture: UITapGestureRecognizer) {
        if let view = gesture.view, let didSelectFooter = baseDelegate?.didSelectFooter {
            didSelectFooter(view.tag)
        }
    }
}

extension BaseTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cellheight = self.cellheight {
            return cellheight
        } else {
            if let cell = tableView.cellForRow(at: indexPath),
               let cellheight = baseDelegate?.cellHeightForRow?(indexPath, cell) {
                return cellheight
            } else {
                return UITableView.automaticDimension
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let sectionHeaderView = self.sectionHeaderView,
           sectionHeaderView.count > section {
            return UITableView.automaticDimension
        } else {
            return .leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let sectionHeaderView = self.sectionHeaderView,
           sectionHeaderView.count > section {
            let headerView = sectionHeaderView[section]
            headerView.tag = section
            baseDelegate?.setupHeader?(headerView,section)
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectedHeader(gesture:)))
            tap.cancelsTouchesInView = false
            headerView.addGestureRecognizer(tap)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let sectionFooterView = self.sectionFooterView,
           sectionFooterView.count > section {
            return UITableView.automaticDimension
        } else {
            return .leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let sectionFooterView = self.sectionFooterView,
           sectionFooterView.count > section {
            let footerView = sectionFooterView[section]
            footerView.tag = section
            baseDelegate?.setupFooter?(footerView,section)
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectedFooter(gesture:)))
            tap.cancelsTouchesInView = false
            footerView.addGestureRecognizer(tap)
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let didSelectRow = self.baseDelegate?.didSelectRow,
           let cell = tableView.cellForRow(at: indexPath) {
            didSelectRow(indexPath, self.dataArray[indexPath.section][indexPath.row], cell)
        }
    }
}

extension BaseTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count > section ? dataArray[section].count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: self.tableCellClassName ?? "") ??  setupDefaultCell()
        if let baseCell = cell as? BaseTableViewCell,
           let setupCell = self.baseDelegate?.setupCell,
           self.dataArray.count > indexPath.section && self.dataArray[indexPath.section].count > indexPath.row {
            setupCell(indexPath, self.dataArray[indexPath.section][indexPath.row], baseCell)
            return baseCell
        }
        return cell
    }
}

extension BaseTableView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.baseDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.baseDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
}
