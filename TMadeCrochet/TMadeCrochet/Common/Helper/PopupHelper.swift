//
//  PopupHelper.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 15/7/24.
//

import Foundation
import UIKit

typealias Action = (() -> Void)

class PopupHelper {
    static let shared = PopupHelper()
    var destinationViewController: BaseViewController?
    
    func showCommonPopup(baseViewController: UIViewController,
                                  titleHeader: String? = "",
                                  activeTitle: String?,
                                  activeAction: ((String) -> Void)?,
                                  cancelTitle: String?,
                                  cancelAction: Action? ) {
        let popupVC = CommonPopup.init(nibName: "CommonPopup", bundle: nil)
        popupVC.load()
        popupVC.setTitleHeader(titleHeader)
        popupVC.setActiveButton(activeTitle)
        popupVC.setActiveButton(activeAction)
        popupVC.setCancelButton(cancelTitle)
        popupVC.setCancelButton(cancelAction)
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.modalTransitionStyle = .crossDissolve
        self.destinationViewController = popupVC
        baseViewController.present(popupVC, animated: true)
    }
}
