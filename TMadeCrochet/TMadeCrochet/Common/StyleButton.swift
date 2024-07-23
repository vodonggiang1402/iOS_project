//
//  StyleButton.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 15/7/24.
//

import Foundation
import UIKit

enum StyleBtn {
    case style_cancel
    case style_ok
    
    var borderWidth: CGFloat {
        switch self {
        case .style_cancel:
            return 1.0
        case .style_ok:
            return 0
        }
    }
    
    var borderColorDisable: UIColor {
        switch self {
        case .style_cancel:
            return .color_main_app_gray
        case .style_ok:
            return .color_main_app_pink
        }
    }
    
    var borderColorEnable: UIColor {
        switch self {
        case .style_cancel:
            return .color_main_app_gray
        case .style_ok:
            return .color_main_app_pink
        }
    }
    
    var borderColorSelected: UIColor {
        switch self {
        case .style_cancel:
            return .color_main_app_gray
        case .style_ok:
            return .color_main_app_pink
        }
    }
    
    var textColorEnable: UIColor {
        switch self {
        case .style_cancel:
            return .color_main_app_gray
        case .style_ok:
            return .color_main_app_gray
        }
    }
    
    var textColorSelected: UIColor {
        switch self {
        case .style_cancel:
            return .color_main_app_gray
        case .style_ok:
            return .color_main_app_gray
        }
    }
    
    var textColorDisable: UIColor {
        switch self {
        case .style_cancel:
            return .color_main_app_gray
        case .style_ok:
            return .color_main_app_gray
        }
    }
    
    var textColorHightLight: UIColor {
        switch self {
        case .style_cancel:
            return .color_main_app_gray
        case .style_ok:
            return .color_main_app_gray
        }
    }
    
    var backGroundColorEnable: UIColor {
        switch self {
        case .style_cancel:
            return .clear
        case .style_ok:
            return .color_main_app_pink
        }
    }
    
    var backGroundColorSelected: UIColor {
        switch self {
        case .style_cancel:
            return .clear
        case .style_ok:
            return .color_main_app_pink
        }
    }
    
    var backGroundColorDisable: UIColor {
        switch self {
        case .style_cancel:
            return .clear
        case .style_ok:
            return .color_main
        }
    }
    
    var backGroundColorHightLight: UIColor {
        switch self {
        case .style_cancel:
            return .clear
        case .style_ok:
            return .color_main_app_pink
        }
    }
}

class StyleButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configButton()
    }
    
    var style: StyleBtn = .style_ok {
        didSet {
            configButton()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.25, delay: 0,
                           options: [.beginFromCurrentState, .allowUserInteraction],
                           animations: { [weak self] in
                guard let self = self else { return }
                if self.isSelected {
                    self.setTitleColor(self.style.textColorSelected, for: .selected)
                    self.titleLabel?.textColor = self.style.textColorSelected
                    self.backgroundColor = self.style.backGroundColorSelected
                    self.borderColor = self.style.borderColorSelected
                } else {
                    self.setTitleColor(self.style.textColorEnable, for: .normal)
                    self.titleLabel?.textColor = self.style.textColorEnable
                    self.backgroundColor = self.style.backGroundColorEnable
                    self.borderColor = self.style.borderColorEnable
                }
            }, completion: nil)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.25, delay: 0,
                           options: [.beginFromCurrentState, .allowUserInteraction],
                           animations: { [weak self] in
                guard let self = self else { return }
                if self.isHighlighted {
                    self.setTitleColor(self.style.textColorHightLight, for: .normal)
                    self.titleLabel?.textColor = self.style.textColorHightLight
                    self.backgroundColor = self.style.backGroundColorHightLight
                } else {
                    self.setTitleColor(self.style.textColorEnable, for: .normal)
                    self.titleLabel?.textColor = self.style.textColorEnable
                    self.backgroundColor = self.style.backGroundColorEnable
                }
            }, completion: nil)
        }
    }
    
    private func configButton() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 2
        self.borderWidth = style.borderWidth
        if self.isEnabled {
            self.setTitleColor(style.textColorEnable, for: .normal)
            self.titleLabel?.textColor = style.textColorEnable
            self.backgroundColor = style.backGroundColorEnable
            self.borderColor = self.style.borderColorEnable
        } else {
            self.backgroundColor = style.backGroundColorDisable
            self.setTitleColor(style.textColorDisable, for: .disabled)
            self.titleLabel?.textColor = style.textColorDisable
            self.borderColor = self.style.borderColorDisable
        }
    }
    
    func setEnable(isEnable: Bool) {
        self.isEnabled = isEnable
        self.configButton()
    }
}
