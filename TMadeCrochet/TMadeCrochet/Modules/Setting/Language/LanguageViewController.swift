//
//  LanguageViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class LanguageViewController: BaseViewController {
    
    @IBOutlet weak var tableView: BaseTableView!
    
    @IBOutlet weak var saveButton: StyleButton!
    var presenter: ViewToPresenterLanguageProtocol?
    var languageAppSetting: [Language] = []
    var currentIndexPath: IndexPath = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "language_screen_header_title".Localizable(), isShowLeft: true)
        setupTable()
        saveButton.style = .style_ok
        saveButton.setEnable(isEnable: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getListLanguage()
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
    
    func setupTable() {
        tableView.configure(tableCellClassName: LanguageTableViewCell.className,
                            baseDelegate: self, hasPull: false,
                            hasLoadMore: false)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataArray = []
        tableView.cellheight = 60
    }
    
    func validateSaveButton() {
        var valid = false
        let item = self.languageAppSetting[self.currentIndexPath.item]
        if AppConstant.localeId != item.id {
            valid = true
        }
        self.saveButton.setEnable(isEnable: valid)
    }
    

    @IBAction func saveButtonAction(_ sender: Any) {
        let item = self.languageAppSetting[self.currentIndexPath.item]
        if AppConstant.localeId != item.id {
            self.presenter?.changeLanguage(indexPath: self.currentIndexPath)
        }
    }
}
    

extension LanguageViewController: PresenterToViewLanguageProtocol {
    func reloadData() {
        if let list = presenter?.languageAppSetting {
            self.languageAppSetting = list
            tableView.dataArray = [self.languageAppSetting]
            tableView.reloadData()
        }
    }
}

extension LanguageViewController: BaseTableViewProtocol {
    // MARK: - TableView delegate, datasource
    func setupCell(_ indexPath: IndexPath, _ dataItem: Any, _ cell: BaseTableViewCell) {
        // TODO: Setup UI for cell
        if let termCell = cell as? LanguageTableViewCell {
            termCell.setupCell(object: dataItem)
        }
    }
    
    func didSelectRow(_ indexPath: IndexPath, _ dataItem: Any, _ cell: UITableViewCell) {
        guard let model = presenter?.languageAppSetting[indexPath.row] else { return }
        self.currentIndexPath = indexPath
        var tempList: [Language] = []
        for var item in self.languageAppSetting {
            if item.id == model.id {
                item.isSelected = true
            } else {
                item.isSelected = false
            }
            tempList.append(item)
        }
        self.languageAppSetting = tempList
        tableView.dataArray = [self.languageAppSetting]
        validateSaveButton()
        tableView.reloadData()
    }
    
    
}
