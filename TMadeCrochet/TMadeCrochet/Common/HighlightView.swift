//
//  HighlightView.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 22/7/24.
//

import Foundation
import UIKit

protocol HighlightViewProtocol: AnyObject {
    func highlight(view: HighlightView)
    func unHighlight(view: HighlightView)
}

class HighlightView: UIView {
    var bgColor: UIColor = .color_fafafa_1818181
    var strokeColor: UIColor = .color_fafafa_1818181
    weak var delegate: HighlightViewProtocol?
    private var isApplyHover: Bool = true
    
    deinit {
        self.delegate = nil
    }
    
    var highlightType: HighlightType = .normal {
        didSet {
            configView()
        }
    }
    
    func setStateApplyHover(_ state: Bool) {
        self.isApplyHover = state
    }
    
    private func configView() {
        unHighlight()
    }
    
    func highlight() {
        self.backgroundColor = self.highlightType.backgroundColor
        self.borderColor = self.highlightType.borderColor
        self.delegate?.highlight(view: self)
    }
    
    func unHighlight() {
        self.backgroundColor = self.bgColor
        self.borderColor = self.strokeColor
        self.delegate?.unHighlight(view: self)
    }
    
    func disabled() {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard isApplyHover else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.highlight()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard isApplyHover else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.unHighlight()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>,
                                   with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard isApplyHover else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.unHighlight()
        }
    }
}

// MARK: TODO @IBInspectable Không nhận giá trị enum? nên phải khai báo type = int
enum HighlightType: Int {
    case normal
    
    var backgroundColor: UIColor {
        switch self {
        case .normal: return .clear
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .normal: return .clear
        }
    }
    
    var colorImage: UIColor {
        switch self {
        case .normal: return .clear
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .normal: return .clear
        }
    }
}
