//
//  AlertView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 8/8/24.
//
import Foundation
import UIKit

class AlertView: BaseViewController {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var cancelButton: StyleButton!
    @IBOutlet weak var activeButton: StyleButton!
    
    private var activeAction: Action?
    private var cancelAction: Action?
    
    @objc func dismissPopup(gesture: UITapGestureRecognizer) {
        self.dismissView()
    }
        
    func dismissView() {
        self.dismiss(animated: true)
    }

    @IBAction func cancelButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        self.dismissView()
    }
    
    
    @IBAction func okButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        self.dismissView()
        self.activeAction?()
    }
    
    
    func setupTheme() {
        setupFont()
        cancelButton.style = .style_cancel
        activeButton.style = .style_ok
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.maskedCorners = [CACornerMask.topLeft, CACornerMask.topRight, CACornerMask.bottomLeft, CACornerMask.bottomRight]
        viewContainer.layer.masksToBounds = true
    }
    
    func setupFont() {
        titleLabel.text = "add_counter_title".Localizable()
        cancelButton.setTitle("cancel_text".Localizable(), for: .normal)
        activeButton.setTitle("ok_text".Localizable(), for: .normal)
    }
    
    // MARK: - IBAction Methods
    @discardableResult
    func load() -> AlertView {
        self.loadView()
        setupTheme()
        return self
    }
    
    @discardableResult
    func setTitleHeader(_ text: String?) -> AlertView {
        self.titleLabel.text = text
        return self
    }
    
    @discardableResult
    func setActiveButton(_ title: String?) -> AlertView {
        activeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.activeButton.setTitle(title, for: .normal)
        self.activeButton.isHidden = title?.isEmpty ?? true
        return self
    }
    
    @discardableResult
    func setActiveButton(_ action: Action?) -> AlertView {
        self.activeAction = action
        return self
    }
    
    @discardableResult
    func setCancelButton(_ title: String?) -> AlertView {
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.cancelButton.setTitle(title, for: .normal)
        self.cancelButton.isHidden = title?.isEmpty ?? true
        return self
    }
    
    @discardableResult
    func setCancelButton(_ action: Action?) -> AlertView {
        self.cancelAction = action
        return self
    }
}
