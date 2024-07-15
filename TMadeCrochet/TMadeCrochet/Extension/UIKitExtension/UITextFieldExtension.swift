//
//  UITextFieldExtension.swift
//  Probit
//
//  Created by Beacon on 22/08/2022.
//

import UIKit

private var __maxLengths = [UITextField: Int]()

extension UITextField {
    @IBInspectable public var localizeText: String {
        get {
            return ""
        }
        set {
            self.placeholder = newValue
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return Int.max // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "",
                                                            attributes: [.foregroundColor: newValue!,
                                                                         .font: UIFont.systemFont(ofSize: 14)])
        }
    }
    
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
    
    func updateBorderStatus(isValid: Bool) {
        let isEditing = self.isEditing
        self.borderColor = UIColor.red
    }
    
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.paste(_:))
    }
    
    func isEmptyOrWhitespace() -> Bool {
        return self.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? false
    }
}

@IBDesignable
class ImageTextField: UITextField {
    
    var textFieldBorderStyle: UITextField.BorderStyle = .roundedRect
    
    // Provides left padding for image
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += padding
        return textRect
    }
    
    // Provides right padding for image
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }
    
    @IBInspectable var fieldImage: UIImage? = nil {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var padding: CGFloat = 0
    @IBInspectable var color: UIColor = UIColor.gray {
        didSet {
            updateView()
        }
    }
    @IBInspectable var bottomColor: UIColor = UIColor.clear {
        didSet {
            if bottomColor == UIColor.clear {
                self.borderStyle = .roundedRect
            } else {
                self.borderStyle = .bezel
            }
            self.setNeedsDisplay()
        }
    }
    
    func updateView() {
        
        if let image = fieldImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.bounds.origin.x, y: self.bounds.height
                              - 0.5))
        path.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.height
                                 - 0.5))
        path.lineWidth = 0.5
        self.bottomColor.setStroke()
        path.stroke()
    }
}

extension UITextField {
    
    private static var clearButtonStatic = ObjectAssociation<UIButton>()
    var clearButton: UIButton? {
        set { UITextField.clearButtonStatic[self] = newValue }
        get { return UITextField.clearButtonStatic[self] }
    }

    func setPasswordClearImage(_ button: UIButton) {
        button.setImage(UIImage(named: "ico_verify_code_close"), for: .highlighted)
        button.setImage(UIImage(named: "ico_verify_code_close"), for: .normal)
    }
    
    func enablePasswordClear(isRTL: Bool = false) {
        let clearView = UIView(frame: CGRect(x: 0,
                                           y: 0, width: 40,
                                           height: frame.size.height))
        clearButton = UIButton(type: .custom)
        clearButton!.frame =  CGRect(x: isRTL ? 40 - 24 : 0,
                                  y: 0, width: 24,
                                  height: frame.size.height)
        clearView.addSubview(clearButton!)
        setPasswordClearImage(clearButton!)
        clearButton!.addTarget(self,
                            action: #selector(self.clearAction),
                            for: .touchUpInside)
        if isRTL {
            leftView = self.text?.count ?? 0 > 0 ? clearView : nil
            leftViewMode = .always
        } else {
            rightView = self.text?.count ?? 0 > 0 ? clearView : nil
            rightViewMode = .always
        }
    }
    
    private static var eyeButtonStatic = ObjectAssociation<UIButton>()
    var eyeButton: UIButton? {
        set { UITextField.eyeButtonStatic[self] = newValue }
        get { return UITextField.eyeButtonStatic[self] }
    }
    
    func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(UIImage(named: "ico_eye_hide"), for: .highlighted)
            button.setImage(UIImage(named: "ico_eye_hide"), for: .normal)
        } else{
            button.setImage(UIImage(named: "ico_eye_show"), for: .highlighted)
            button.setImage(UIImage(named: "ico_eye_show"), for: .normal)
        }
    }
    
    func removePasswordToggle(isRTL: Bool = false) {
        isSecureTextEntry = false
        if isRTL {
            leftView = nil
            leftViewMode = .never
        } else {
            rightView = nil
            rightViewMode = .never
        }
    }
    
    func enablePasswordToggle(isRTL: Bool = false) {
        
        let eyeView = UIView(frame: CGRect(x: 0,
                                           y: 0, width: 40,
                                           height: frame.size.height))
        eyeButton = UIButton(type: .custom)
        eyeButton!.frame =  CGRect(x: isRTL ? 40 - 24 : 0,
                                  y: 0, width: 24,
                                  height: frame.size.height)
        eyeView.addSubview(eyeButton!)
        isSecureTextEntry = true
        setPasswordToggleImage(eyeButton!)
        eyeButton!.addTarget(self,
                            action: #selector(self.togglePasswordView),
                            for: .touchUpInside)
        if isRTL {
            leftView = eyeView
            leftViewMode = .always
        } else {
            rightView = eyeView
            rightViewMode = .always
        }
    }
    
    func enablePasswordToggleAndClear(isRTL: Bool = false, updateText: String? = "") {
        var hasText: Bool = false
        if let text = updateText, text.count > 0 {
            hasText = true
        }
        
        let containerView = UIView(frame: CGRect(x: 0,
                                           y: 0, width: hasText ? 80 : 40,
                                           height: frame.size.height))
        containerView.backgroundColor = UIColor.clear
        
        if hasText {
            clearButton = UIButton(type: .custom)
            clearButton!.frame =  CGRect(x: isRTL ? 40 - 24 : 0,
                                         y: 0, width: 24,
                                         height: frame.size.height)
            clearButton?.backgroundColor = UIColor.clear
            containerView.addSubview(clearButton!)
            
            setPasswordClearImage(clearButton!)
            clearButton!.addTarget(self,
                                action: #selector(self.clearPasswordView),
                                for: .touchUpInside)
        }

        
        eyeButton = UIButton(type: .custom)
        eyeButton?.backgroundColor = UIColor.clear
        eyeButton!.frame =  CGRect(x: isRTL ? 40 - 24 : hasText ? 40 : 0,
                                  y: 0, width: 24,
                                  height: frame.size.height)
        containerView.addSubview(eyeButton!)
        
        setPasswordToggleImage(eyeButton!)
        eyeButton!.addTarget(self,
                            action: #selector(self.togglePasswordView),
                            for: .touchUpInside)
        
        if isRTL {
            leftView = containerView
            leftViewMode = .always
        } else {
            rightView = containerView
            rightViewMode = .always
        }
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        guard let button = sender as? UIButton else { return }
        setPasswordToggleImage(button)
        self.didChangeIsSecureTextEntry(isSecureTextEntry: self.isSecureTextEntry)
    }
    
    @objc func didChangeIsSecureTextEntry(isSecureTextEntry: Bool) {
        
    }
    
    @objc func clearPasswordView(_ sender: Any) {
        self.text = nil
        self.didChangeClearTextEntry()
    }
    
    @objc func clearAction(_ sender: Any) {
        self.text = nil
        self.didChangeClearTextEntry()
    }
    
    @objc func didChangeClearTextEntry() {
        
    }
}

extension UITextField {
    func animation(typing value: String, duration: Double){
        let characters = value.map { $0 }
        var index = 0
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true, block: { [weak self] timer in
            if index < value.count {
                let char = characters[index]
                self?.text! += "\(char)"
                index += 1
            } else {
                timer.invalidate()
            }
        })
    }
    
    func textWithAnimation(text: String, duration: CFTimeInterval){
        fadeTransition(duration)
        self.text = text
    }
}

extension UITextField {
    func moveCoursoreToEnd(){
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }
}

public final class ObjectAssociation<T: AnyObject> {

    private let policy: objc_AssociationPolicy

    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {

        self.policy = policy
    }

    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public subscript(index: AnyObject) -> T? {

        get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}
