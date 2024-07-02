//
//  MainViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class MainViewController: BaseViewController {
    
    private let bannerSection = BannerSection()
    
    var presenter: ViewToPresenterMainProtocol?
    @IBOutlet weak var tableView: BaseTableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar(isHide: true)
        self.setupTable()
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setContentOffset(.zero, animated: false)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        let header = StrechyHeaderView(frame: CGRect(x: 0, y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: 200))
        header.imageView.image = UIImage(named: "banner_crochet")
        tableView.tableHeaderView = header
        
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0.0 }
        tableView.register(cellType: MainTableCell.self)
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
}
    

extension MainViewController: PresenterToViewMainProtocol {
    
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
            let cell = try tableView.dequeueReusableCell(MainTableCell.self)
            return cell
        } catch (let error) {
            print("error", error)
        }
        return MainTableCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StrechyHeaderView else {
            return
        }
        header.scrollViewDidScroll(scrollView: tableView)
    }
}
