//
//  TFACommonVC.swift
//  Probit
//
//  Created by Vo Dong Giang on 28/05/2024.
//

import Foundation
import UIKit

class CommonPopup: BaseViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var titleHeaderLabel: UILabel!
    
    @IBOutlet weak var pinInputView: InLineTextField!
    @IBOutlet weak var heightTextFieldConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var cancelButton: StyleButton!
    @IBOutlet weak var activeButton: StyleButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    private var activeAction: ((String) -> Void)?
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
       var text = self.pinInputView.getInputText()
        if text.isEmpty {
            text = "Bộ đếm"
        }
        self.dismissView()
        self.activeAction?(text)
    }
    
    func setupTextField() {
        pinInputView.delegate = self
        pinInputView.inputTextField.delegate = self
        pinInputView.title = ""
        pinInputView.placeHolder = "Nhập"
        pinInputView.inputTextField.font = UIFont.systemFont(ofSize: 14)
        pinInputView.isSecureTextEntry = false
        pinInputView.textFieldType = .normal
        pinInputView.setKeyboardType(.default)
        pinInputView.setBackgroundColor(color: .clear)
    }
    
    func setupTheme() {
        setupFont()
        cancelButton.style = .style_cancel
        activeButton.style = .style_ok
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.maskedCorners = [CACornerMask.topLeft, CACornerMask.topRight]
        viewContainer.layer.masksToBounds = true
        setupTextField()
    }
    
    func setupFont() {
        titleHeaderLabel.font = UIFont.systemFont(ofSize: 18)
        titleHeaderLabel.text = ""
        cancelButton.setTitle("", for: .normal)
        activeButton.setTitle("", for: .normal)
    }
    
    override func updateLayoutWhenKeyboardChanged(height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.bottomConstraint.constant = height > 0 ? height + 30 : 0
            self.view.layoutIfNeeded()
        }
    }
    
    func enableNextButton(_ enable: Bool) {
        activeButton.setEnable(isEnable: enable)
    }
    
    // MARK: - IBAction Methods
    @discardableResult
    func load() -> CommonPopup {
        self.loadView()
        setupTheme()
        addObserverKeyBoard()
        self.view.hideKeyboard()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissPopup(gesture:)))
        tapGesture.cancelsTouchesInView = true
        backView.addGestureRecognizer(tapGesture)
        
        return self
    }
    
    @discardableResult
    func setTitleHeader(_ text: String?) -> CommonPopup {
        self.titleHeaderLabel.text = text
        self.headerStackView.isHidden = (text?.isEmpty ?? true)
        return self
    }
    
    @discardableResult
    func setActiveButton(_ title: String?) -> CommonPopup {
        activeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.activeButton.setTitle(title, for: .normal)
        self.activeButton.isHidden = title?.isEmpty ?? true
        return self
    }
    
    @discardableResult
    func setActiveButton(_ action: ((String) -> Void)?) -> CommonPopup {
        self.activeAction = action
        return self
    }
    
    @discardableResult
    func setCancelButton(_ title: String?) -> CommonPopup {
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.cancelButton.setTitle(title, for: .normal)
        self.cancelButton.isHidden = title?.isEmpty ?? true
        return self
    }
    
    @discardableResult
    func setCancelButton(_ action: Action?) -> CommonPopup {
        self.cancelAction = action
        return self
    }

    func setupErrorTextField(error: String) {
        pinInputView.setupTextField(error: error)
        heightTextFieldConstraint.constant = 105
    }
}

// MARK: - InLineDelegate
extension CommonPopup: InLineDelegate {
    func didValidateTextField(_ inlineTextfield: InLineTextField) {
    }
    
    func didBeginEdittingTextField(_ inlineTextfield: InLineTextField) {
        
    }
    
    func didEndEdittingTextField(_ inlineTextfield: InLineTextField) {

    }
    
    func edittingTextField(_ inlineTextfield: InLineTextField) {
    }
    
    func returnErrorTextField(_ inlineTextfield: InLineTextField, isError: Bool) {
    }
}

// MARK: - RTLTextFieldDelegate
extension CommonPopup: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
