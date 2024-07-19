//
//  InLineTextField.swift
//  Earable
//
//  Created by Beacon on 08/06/2022.
//  Copyright © 2022 Earable. All rights reserved.
//

import UIKit
import Foundation

enum InputType: Int {
    case normal = 0
}

protocol InLineDelegate: AnyObject {
    func didValidateTextField(_ inlineTextfield: InLineTextField)
    func didBeginEdittingTextField(_ inlineTextfield: InLineTextField)
    func didEndEdittingTextField(_ inlineTextfield: InLineTextField)
    func edittingTextField(_ inlineTextfield: InLineTextField)
    func returnErrorTextField(_ inlineTextfield: InLineTextField, isError: Bool)
}

extension InLineDelegate {
    func didEndEdittingTextField(_ inlineTextfield: InLineTextField) {}
    func edittingTextField(_ inlineTextfield: InLineTextField) {}
    func returnErrorTextField(_ inlineTextfield: InLineTextField, isError: Bool) {}
}


class InLineTextField: BaseView {
    @IBOutlet private weak var inputTextView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var inputTextField: RTLTextField!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var requiredLabel: UILabel!
    
    weak var delegate: InLineDelegate?
    
    private var _textDidChange: Bool = false
    
    var needChangeOtherBorder: (() -> Void)?
    var shouldCheckTextLength: Int?
    var referenceString = ""
    
    var textFieldType: InputType = .normal {
        didSet {
            switch textFieldType {
            default:
                self.isSecureTextEntry = false
            }
        }
    }
    
    var textDidChange: Bool { return _textDidChange }
    
    deinit {
        self.inputTextField?.delegateRTL = nil
        self.inputTextField?.delegate = nil
        self.delegate = nil
    }
    
    @IBInspectable var placeHolder: String {
        get {
            return inputTextField.placeholder ?? ""
        }
        set {
            inputTextField.placeholder = newValue
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            return inputTextField.maxLength
        }
        set {
            inputTextField.maxLength = newValue
        }
    }
    
    @IBInspectable var required: Bool {
        get {
            return !requiredLabel.isHidden
        }
        set {
            requiredLabel.isHidden = !newValue
        }
    }
    
    @IBInspectable var isEnabled: Bool {
        get {
            return inputTextField.isEnabled
        }
        set {
            inputTextField.isEnabled = newValue
        }
    }
    
    @IBInspectable var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    @IBInspectable var titleAttributedText: NSAttributedString? {
        get {
            return titleLabel.attributedText
        }
        set {
            titleLabel.attributedText = newValue
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        get {
            return inputTextField.placeHolderColor
        }
        set {
            inputTextField.placeHolderColor = newValue
        }
    }
    
    @IBInspectable var isSecureTextEntry: Bool {
        get {
            return inputTextField.isSecureTextEntry
        }
        set {
            inputTextField.isSecureTextEntry = newValue
        }
    }
    
    var backgroundTextViewColor: UIColor? {
        didSet {
            inputTextView.backgroundColor = backgroundTextViewColor
        }
    }
    
    // MARK: Export view info
    func getInputText() -> String {
        return inputTextField.text?.asTrimmed ?? ""
    }
    
    func getErrorMessage() -> String {
        return errorLabel.text ?? ""
    }
    
    func inputTextValid() -> Bool {
        return errorLabel.text?.isEmpty ?? false
    }
    
    // MARK: Setup TextField
    func setupTextField(title: String = "", error: String = "") {
        if !title.isEmpty {
            titleLabel.text = title
        }
        errorLabel.text = error
        errorLabel.isHidden = error.isEmpty
        updateBorderStatus()
        self.delegate?.returnErrorTextField(self, isError: !error.isEmpty)
    }
    
    func setInputText(newText: String) {
        inputTextField.text = newText
    }
    
    func setKeyboardType(_ type: UIKeyboardType) {
        self.inputTextField.keyboardType = type
    }
    
    func validateInputText() {
        let inputText = self.inputTextField.text ?? ""
        var errorMessage = "Trống"
        switch self.textFieldType {
        case .normal:
            errorMessage = ""
        }
        inputTextField.text = String(inputText.prefix(maxLength))
        setupTextField(error: errorMessage)
        self.delegate?.didValidateTextField(self)
    }
    
    func updateBorderStatus() {
        switch textFieldType {
        default:
            let isFocus = inputTextField.isEditing
            let defaultColor = isFocus ? UIColor.color_main_app_pink : UIColor.color_b6b6b6_7b7b7b
            let errorMessage = errorLabel.text ?? ""
            var borderColor = errorMessage.isEmpty ? defaultColor : UIColor.red
            borderColor = (!isFocus && errorMessage.isEmpty) ? defaultColor : borderColor
            inputTextView.layer.borderColor = borderColor.cgColor
        }
    }
    
    func setupRightToLeft(_ isRTL: Bool) {
        if isRTL {
            inputTextField.setLeftPaddingPoints(10)
        }
    }
    
    // MARK: TextField actions
    @IBAction func editingTextField(_ sender: UITextField) {
        self._textDidChange = true
        validateInputText()
        self.delegate?.edittingTextField(self)
    }
    
    @IBAction func didBeginEdittingTextField(_ sender: Any) {
        errorLabel.isHidden = true
        validateInputText()
        self.delegate?.didBeginEdittingTextField(self)
    }
    @IBAction func didEndEditingTextField(_ sender: UITextField) {
        updateBorderStatus()
        if let changeBorder = self.needChangeOtherBorder {
            changeBorder()
        }
        self.delegate?.didEndEdittingTextField(self)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.paste(_:))
    }
}
