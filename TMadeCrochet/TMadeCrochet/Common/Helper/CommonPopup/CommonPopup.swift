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
    

    @IBAction func cancelButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        self.cancelAction?()
    }
    
    
    @IBAction func okButtonAction(_ sender: Any) {
        self.view.endEditing(true)
       let pin = self.pinInputView.getInputText()
        if !pin.isEmpty {
            self.activeAction?(pin)
        }
    }
    
    func setupTextField() {
        pinInputView.delegate = self
        pinInputView.inputTextField.delegate = self
        pinInputView.title = ""
        pinInputView.placeHolder = ""
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
    
    func validateNextButton() {
        let pin = self.pinInputView.getInputText()
        let validate = !pin.isEmpty && self.pinInputView.getErrorMessage().isEmpty
        self.enableNextButton(validate)
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
        if inlineTextfield == pinInputView {
            heightTextFieldConstraint.constant = pinInputView.inputTextValid() ? 78 : 105
        }
        self.validateNextButton()
    }
    
    func didBeginEdittingTextField(_ inlineTextfield: InLineTextField) {
        
    }
    
    func didEndEdittingTextField(_ inlineTextfield: InLineTextField) {

    }
    
    func edittingTextField(_ inlineTextfield: InLineTextField) {
        if inlineTextfield == pinInputView {
            heightTextFieldConstraint.constant = pinInputView.inputTextValid() ? 78 : 105
        }
        self.validateNextButton()
    }
    
    func returnErrorTextField(_ inlineTextfield: InLineTextField, isError: Bool) {
        if inlineTextfield == pinInputView {
            heightTextFieldConstraint.constant = isError ? 105 : 78
        }
    }
}

// MARK: - RTLTextFieldDelegate
extension CommonPopup: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
