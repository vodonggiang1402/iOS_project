//
//  BaseTableViewCell.swift
//  Probit
//
//  Created by Beacon on 10/08/2022.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    var bgColor: UIColor = UIColor.colorFafafa181818

    private var isApplyHover: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    deinit {
        self.gestureRecognizers?.forEach({ gesture in
            self.removeGestureRecognizer(gesture)
        })
    }
    
    func setupCell(object: Any) {

    }

    func setStateApplyHover(_ state: Bool) {
        self.isApplyHover = state
    }

    func setupCell(object: Any, indexPath: IndexPath? = nil) {
        
    }
    
    func localizable() {
        
    }
    
    func setupRightToLeft(_ isRTL: Bool) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard isApplyHover else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = UIColor.clear
            UIView.animate(withDuration: 0.2,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: {
                self.backgroundColor =  UIColor.clear
            }, completion: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard isApplyHover else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = UIColor.clear
            UIView.animate(withDuration: 0.2,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: {
                self.backgroundColor =  UIColor.clear
            }, completion: nil)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>,
                                   with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard isApplyHover else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = UIColor.clear
            UIView.animate(withDuration: 0.2,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: {
                self.backgroundColor =  UIColor.clear
            }, completion: nil)
        }
    }
}
