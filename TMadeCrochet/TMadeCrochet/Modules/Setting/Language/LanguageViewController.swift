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
    
    var presenter: ViewToPresenterLanguageProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "Ngôn ngữ", isShowLeft: true)
        presenter?.getListLanguage()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        tableView.dataArray = [presenter?.languageAppSetting ?? []]
        tableView.cellheight = 60
    }

}
    

extension LanguageViewController: PresenterToViewLanguageProtocol {
    func reloadData() {
        tableView.dataArray = [presenter?.languageAppSetting ?? []]
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
//        showPopupHelperForLanguage("__notice".Localizable(langCode: model.id),
//                                   language: model,
//                                   message: "dialog_restart_needed_content".LocalizableForChangeLanguage(langCode: model.id, isLanguageRightToLeft: self.isRightToLeft(forLanguage: model)),
//                                   acceptTitle: "__common_confirm".Localizable(langCode: model.id),
//                                   cancleTitle: "__cancel".Localizable(langCode: model.id),
//                                   acceptAction: {
//            self.presenter?.changeLanguage(indexPath: indexPath)
//        }, cancelAction: nil)
    }
}
