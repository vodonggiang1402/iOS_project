//
//  RTLTextField.swift
//  Probit
//
//  Created by Bradley Hoang on 19/12/2022.
//

import UIKit

protocol RTLTextFieldDelegate: AnyObject {
    func didChangeIsSecureTextEntry(isSecureTextEntry: Bool)
    func focusTextField(_ textField: RTLTextField)
    func unFocusTextField(_ textField: RTLTextField)
    func didChangeClearTextEntry(_ textField: RTLTextField)
}

extension RTLTextFieldDelegate {
    func didChangeIsSecureTextEntry(isSecureTextEntry: Bool) {}
    func focusTextField(_ textField: RTLTextField) {}
    func unFocusTextField(_ textField: RTLTextField) {}
    func didChangeClearTextEntry(_ textField: RTLTextField) {}
}

class RTLTextField: UITextField {
    // MARK: - Lifecycle
    weak var delegateRTL: RTLTextFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
    }
    
    deinit {
        self.delegateRTL = nil
    }
    
    override func didChangeIsSecureTextEntry(isSecureTextEntry: Bool) {
        delegateRTL?.didChangeIsSecureTextEntry(isSecureTextEntry: isSecureTextEntry)
    }
    
    override func becomeFirstResponder() -> Bool {
        let didBecomeFirstResponder = super.becomeFirstResponder()
        if didBecomeFirstResponder {
            delegateRTL?.focusTextField(self)
        }
        return didBecomeFirstResponder
    }
    
    override func resignFirstResponder() -> Bool {
        let didResignFirstResponder = super.resignFirstResponder()
        if didResignFirstResponder {
            delegateRTL?.unFocusTextField(self)
        }
        return didResignFirstResponder
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.paste(_:))
    }
    
    override func didChangeClearTextEntry() {
        delegateRTL?.didChangeClearTextEntry(self)
    }
}

// MARK: - Private

private extension RTLTextField {
    func setupRightToLeft(_ isRTL: Bool) {
        textAlignment = isRTL ? .right : .left
    }
}
